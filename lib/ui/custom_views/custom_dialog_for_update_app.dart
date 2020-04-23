import 'package:flutter/material.dart';

class CustomDialogForUpdateApp extends StatelessWidget {
  final VoidCallback listener;
  final String title;
  final String content;
  final String appBarTitle;
  final bool isImage;
  final VoidCallback declineListener;
  final bool showCancel;

  const CustomDialogForUpdateApp({
    Key key,
    @required this.listener,
    @required this.title,
    this.appBarTitle,
    this.showCancel = true,
    this.isImage = true,
    this.content,
    this.declineListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              isImage
                  ? Container(
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: CustomHorizontalLinearGradient(),
                      ),
                      child: Center(
                          child: Text(
                        appBarTitle,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        color: Color(0xff535353),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (content != null)
                      SizedBox(
                        height: 10,
                      ),
                    if (content != null)
                      Text(
                        content,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 12,
                          decoration: TextDecoration.none,
                          color: Color(0xff535353),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        if (showCancel)
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            onPressed: () {
                              if (declineListener != null) {
                                declineListener();
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              'NO',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            listener();
                          },
                          child: const Text(
                            'CONFIRM',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomHorizontalLinearGradient extends LinearGradient {
  CustomHorizontalLinearGradient()
      : super(colors: [
          Colors.blue,
          Colors.blue,
        ]);

  @override
  AlignmentGeometry get begin => Alignment.centerLeft;

  @override
  TileMode get tileMode => TileMode.clamp;
}
