import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locazshopper/constants/route_paths.dart';
import 'package:locazshopper/db/models/product.dart';
import 'package:locazshopper/ui/custom_views/custom_dialog_for_update_app.dart';
import 'package:locazshopper/ui/custom_views/custom_naivigation_button.dart';
import 'package:locazshopper/ui/screens/product/product_screen.dart';
import 'package:locazshopper/utils/common_utils.dart';
import 'package:toast/toast.dart';

class PlaceOrderScreen extends StatefulWidget {
  final List<CartItem> cartItemList;

  const PlaceOrderScreen({Key key, this.cartItemList}) : super(key: key);

  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  int totalPrice = 0;

  @override
  void initState() {
    widget.cartItemList.map((item) {
      int price = int.parse(item.quantity) * item.productDetails.price;
      totalPrice += price;
    }).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
        ),
        body: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Order Name'),
                          SizedBox(
                            width: 70,
                          ),
                          Text('Quantity'),
                          Text('Amount'),
                          Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    ListView.builder(
                        itemCount: widget?.cartItemList?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 8),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                        width: 100,
                                        child: Text(widget.cartItemList[index]
                                            .productDetails.itemName)),
                                    SizedBox(
                                      width: 70,
                                    ),
                                    Text(widget.cartItemList[index].quantity
                                        .toString()),
                                    Text(
                                        "₹ ${widget.cartItemList[index].productDetails.price.toString()}"),
                                    Text(
                                      '₹ ${int.parse(widget.cartItemList[index].quantity) * widget.cartItemList[index].productDetails.price}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                Divider(
                                  thickness: 2,
                                ),
                              ],
                            ),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Total Price',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            '₹ $totalPrice',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          CustomNavigationButton(
                            title: 'Place Order'.toUpperCase(),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return CustomDialogForUpdateApp(
                                        listener: () async {
                                          await saveRequestedOrder();
                                        },
                                        declineListener: () {
                                          Navigator.pop(context);
                                        },
                                        showCancel: true,
                                        appBarTitle: 'Place Order',
                                        title:
                                            'Press confirm button to place the order');
                                  });
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        )));
  }

  saveRequestedOrder() async {
    Toast.show("please wait...", context, gravity: Toast.CENTER);
    final user = await FirebaseAuth.instance.currentUser();
    Order order = Order();
    List<ProductRequest> productList = List();
    order.totalPrice = totalPrice;
    order.userId = user.uid;
    widget.cartItemList.map((item) {
      ProductRequest productRequest = ProductRequest(
          userId: user.uid,
          productId: item.productId,
          ownerId: item.ownerId,
          quantity: item.quantity,
          brand: item.brand);
      productList.add(productRequest);
    }).toList();
    order.productRequestList = productList;
    Firestore.instance
        .collection('requestedOrders')
        .add(order.toMap())
        .then((response) {
      removeUntilNavigateTo(context: context, value: RoutePaths.homeScreen);
      showToast("Your Order Placed Successfully.", context);
    }).catchError((error) {
      print("error ${error.toString()}");
    });
  }
}
