import 'package:cloud_firestore/cloud_firestore.dart';

mixin DbModel<T> {
  DocumentReference ref;

  Map<dynamic, dynamic> toJson() {
    throw ('toJson not implemented');
  }

  T fromSnapshot(DocumentSnapshot snap) {
    throw ('fromJson not implemented');
  }
}
