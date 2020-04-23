import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locazshopper/constants/route_paths.dart';
import 'package:locazshopper/ui/shared/base_widget.dart';
import 'package:locazshopper/utils/common_utils.dart';
import 'package:locazshopper/viewmodels/home/home_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeModel>(
      model: HomeModel(),
      onModelReady: (model) => model.getOwnerDataList(),
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    'Hii ${(model?.username != null) ?? false ? model.username : ''}')),
            body: SafeArea(
              child: (model?.ownerList?.length ?? 0) > 0
                  ? GridView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(8),
                      itemCount: model.ownerList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.75),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            navigateToWithArg(context, RoutePaths.productScreen,
                                dynamicValue:
                                    model.ownerList[index].ref.documentID);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: model?.ownerList[index]?.img ??
                                    'https://via.placeholder.com/150?text= ',
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                  backgroundColor: Colors.red,
                                ),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                model?.ownerList[index]?.shopName ?? '',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(32, 32, 32, 60),
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ));
      },
    );
  }
}
