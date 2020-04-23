import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fimber/fimber.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locazshopper/db/models/product.dart';
import 'package:locazshopper/viewmodels/base_model.dart';

class UserOrdersModel extends BaseModel {
  List<Order> _orderList = List();

  List<Order> get orderList => _orderList;

  set orderList(List<Order> orderList) {
    _orderList = orderList;
    notifyListeners();
  }

  FirebaseUser _user;

  FirebaseUser get user => _user;

  set user(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  Future<void> init() async {
    user = await FirebaseAuth.instance.currentUser();
    await getUserOrdersList();
  }

  Future<void> getUserOrdersList() async {
    _orderList = (await Firestore.instance
            .collection('requestedOrders')
            .where('user_id', isEqualTo: user.uid)
            .getDocuments())
        .documents
        .map((snap) => Order.fromMap(snap))
        .toList();
    Fimber.i(_orderList.length.toString());
    notifyListeners();
  }
}
