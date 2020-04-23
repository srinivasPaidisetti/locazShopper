import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:locazshopper/db/models/product.dart';
import 'package:locazshopper/ui/shared/base_widget.dart';
import 'package:locazshopper/viewmodels/user_order/user_orders_model.dart';

class UserOrdersScreen extends StatefulWidget {
  @override
  _UserOrdersScreenState createState() => _UserOrdersScreenState();
}

class _UserOrdersScreenState extends State<UserOrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<UserOrdersModel>(
        model: UserOrdersModel(),
        onModelReady: (model) => model.init(),
        builder: (context, model, child) {
          return Scaffold(
              body: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model?.orderList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: <Widget>[
                          Text(model.orderList[index].orderId),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('item Name'),
                                Text('Quantity'),
                                Text('Price')
                              ],
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: model?.orderList[index]
                                      ?.productRequestList?.length ??
                                  0,
                              itemBuilder: (context, index1) {
                                return Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[],
                                    )
                                  ],
                                );
                              })
                        ],
                      ),
                    );
                  }));
        });
  }

  Future<Product> getProductDetails(productId, ownerId) async {
    final response = (await Firestore.instance
            .collection('owners')
            .document(ownerId)
            .collection('products')
            .document(productId)
            .get())
        .data;
    return Product.fromSnapshot(response);
  }
}
