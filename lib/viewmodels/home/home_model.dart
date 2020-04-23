import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locazshopper/db/models/owner.dart';
import 'package:locazshopper/viewmodels/base_model.dart';

class HomeModel extends BaseModel {
  FirebaseUser _user;

  FirebaseUser get user => _user;

  set user(FirebaseUser user) {
    _user = user;
    notifyListeners();
  }

  String _username;

  String get username => _username;

  set username(String username) {
    _username = username;
    notifyListeners();
  }

  List<Owner> _ownerList;

  List<Owner> get ownerList => _ownerList;

  set ownerList(List<Owner> ownerList) {
    _ownerList = ownerList;
    notifyListeners();
  }

  getOwnerDataList() async {
    _user = await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection('users')
        .document(_user.uid)
        .get()
        .then((result) {
      _username = result.data['user_name'];
      notifyListeners();
    });
    _ownerList = (await Firestore.instance.collection('owners').getDocuments())
        .documents
        .map((snap) => Owner.fromMap(snap))
        .toList();
    notifyListeners();
  }
}
