import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locazshopper/db/models/product.dart';
import 'package:locazshopper/ui/screens/product/product_screen.dart';
import 'package:locazshopper/viewmodels/base_model.dart';

class ProductModel extends BaseModel {
  List<CartItem> _cartList = List();

  List<CartItem> get cartList => _cartList;

  setCartList(List<CartItem> cartList) {
    _cartList = cartList;
    notifyListeners();
  }

  List<Product> _productList = List();

  List<Product> get productList => _productList;

  set productList(List<Product> productList) {
    _productList = productList;
    notifyListeners();
  }

  void addItem(CartItem cartItem) {
    _cartList.add(cartItem);
    notifyListeners();
  }

  void removeItem(CartItem cartItem) {
    _cartList.removeWhere((item) => item.productId == cartItem.productId);
    notifyListeners();
  }

  List<Brand> _brandsList = List();

  getProductsList(String documentId) async {
    _productList = (await Firestore.instance
            .collection('owners')
            .document(documentId)
            .collection("products")
            .getDocuments())
        .documents
        .map((snap) => Product.fromMap(snap))
        .toList();
    notifyListeners();
  }
}
