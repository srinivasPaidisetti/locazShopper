import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locazshopper/db/db_model.dart';

class Product implements DbModel<Product> {
  DocumentReference reference;
  String itemName;
  int price;
  String quantity;
  String img;
  int availableCount;
  List<Brand> brands;

  Product({
    this.reference,
    this.itemName,
    this.price,
    this.quantity,
    this.img,
    this.availableCount,
    this.brands,
  });

  factory Product.fromMap(DocumentSnapshot json) => Product(
        reference: json.reference,
        itemName: json["item_name"] == null ? null : json["item_name"],
        price: json["price"] == null ? null : json["price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        img: json["img"] == null ? null : json["img"],
        availableCount:
            json["available_count"] == null ? null : json["available_count"],
        brands: json["brands"] == null
            ? null
            : List<Brand>.from(json["brands"].map((x) => Brand.fromMap(x))),
      );

  factory Product.fromSnapshot(Map<String, dynamic> json) => Product(
        itemName: json["item_name"] == null ? null : json["item_name"],
        price: json["price"] == null ? null : json["price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        img: json["img"] == null ? null : json["img"],
        availableCount:
            json["available_count"] == null ? null : json["available_count"],
        brands: json["brands"] == null
            ? null
            : List<Brand>.from(json["brands"].map((x) => Brand.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "item_name": itemName == null ? null : itemName,
        "price": price == null ? null : price,
        "quantity": quantity == null ? null : quantity,
        "img": img == null ? null : img,
        "available_count": availableCount == null ? null : availableCount,
        "brands": brands == null
            ? null
            : List<dynamic>.from(brands.map((x) => x.toMap())),
      };

  @override
  DocumentReference ref;

  @override
  Product fromSnapshot(DocumentSnapshot snap) {
    return Product.fromMap(snap);
  }

  @override
  Map toJson() {
    // TODO: implement toJson
    return null;
  }
}

class Brand {
  String name;
  int price;

  Brand({
    this.name,
    this.price,
  });

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
      );

  Map<String, dynamic> toMap() => {
        "name": name == null ? null : name,
        "price": price == null ? null : price,
      };
}

class Order {
  String orderId;
  String userId;
  List<ProductRequest> productRequestList = List();
  int totalPrice;

  Order({this.orderId, this.userId, this.productRequestList, this.totalPrice});

  factory Order.fromMap(DocumentSnapshot json) => Order(
        orderId: json.documentID,
        userId: json["user_id"] == null ? null : json["user_id"],
        totalPrice: json["total_price"] == null ? null : json["total_price"],
        productRequestList: json["order_list"] == null
            ? null
            : List<ProductRequest>.from(
                    json["order_list"].map((x) => ProductRequest.fromMap(x)))
                .toList(),
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId == null ? null : userId,
        "total_price": totalPrice == null ? null : totalPrice,
        "order_list": productRequestList == null
            ? null
            : List<dynamic>.from(productRequestList.map((x) => x.toMap())),
      };
}

class ProductRequest {
  Product productDetails;
  String userId;
  String productId;
  String ownerId;
  String quantity;
  String brand;

  ProductRequest({
    this.userId,
    this.productId,
    this.productDetails,
    this.ownerId,
    this.quantity,
    this.brand,
  });

  factory ProductRequest.fromMap(Map<String, dynamic> json) => ProductRequest(
        userId: json["user_id"] == null ? null : json["user_id"],
        productId: json["product_id"] == null ? null : json["product_id"],
        ownerId: json["owner_id"] == null ? null : json["owner_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        brand: json["brand"] == null ? null : json["brand"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId == null ? null : userId,
        "product_id": productId == null ? null : productId,
        "owner_id": ownerId == null ? null : ownerId,
        "quantity": quantity == null ? null : quantity,
        "brand": brand == null ? null : brand,
      };
}
