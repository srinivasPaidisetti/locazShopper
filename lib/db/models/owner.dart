import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locazshopper/db/db_model.dart';

class Owner implements DbModel<Owner> {
  DocumentReference ref;
  String area;
  String img;
  String locality;
  String shopName;
  String ownerName;

  Owner({
    this.ref,
    this.area,
    this.img,
    this.locality,
    this.shopName,
    this.ownerName,
  });

  factory Owner.fromMap(DocumentSnapshot json) => Owner(
        ref: json.reference,
        area: json["area"] == null ? null : json["area"],
        img: json["img"] == null ? null : json["img"],
        locality: json["locality"] == null ? null : json["locality"],
        shopName: json["shop_name"] == null ? null : json["shop_name"],
        ownerName: json["owner_name"] == null ? null : json["owner_name"],
      );

  Map<String, dynamic> toMap() => {
        "area": area == null ? null : area,
        "img": img == null ? null : img,
        "locality": locality == null ? null : locality,
        "shop_name": shopName == null ? null : shopName,
        "owner_name": ownerName == null ? null : ownerName,
      };

  @override
  Owner fromSnapshot(DocumentSnapshot snap) {
    return Owner.fromMap(snap);
  }

  @override
  Map toJson() {
    // TODO: implement toJson
    return null;
  }
}
