import 'package:flutter/material.dart';

class CustomNavigationButton extends StatelessWidget {
  final String title;
  final List<Color> colors;
  final double width;
  final double height;
  final Color color;
  final double widthFactor;
  final double heightFactor;
  final Function onPressed;
  final bool enabled;

  const CustomNavigationButton({
    Key key,
    @required this.title,
    this.colors,
    this.width,
    this.height,
    this.color,
    this.widthFactor,
    this.heightFactor,
    this.onPressed,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      gradient: (colors != null)
          ? LinearGradient(
              colors: colors,
              tileMode: TileMode.clamp,
            )
          : (color == null)
              ? LinearGradient(
                  colors: enabled ?? true
                      ? [Color(0xff04c5d5), Colors.blue]
                      : [
                          Colors.red.withOpacity(.6),
                          Colors.red.withOpacity(.6)
                        ],
                  tileMode: TileMode.clamp,
                )
              : null,
      color: color,
      borderRadius: BorderRadius.circular(5),
    );
    return FractionallySizedBox(
      widthFactor: widthFactor,
      heightFactor: heightFactor,
      child: Container(
        width: width,
        height: height ?? 50,
        child: Material(
          elevation: enabled ?? true ? 4 : 0,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: boxDecoration,
            child: Material(
              type: MaterialType.transparency,
              elevation: 4,
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.white.withAlpha(80),
                borderRadius: BorderRadius.circular(35),
                onTap: onPressed ??
                    () {
                      print("didn't implemented onTap");
                    },
                child: Container(
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
