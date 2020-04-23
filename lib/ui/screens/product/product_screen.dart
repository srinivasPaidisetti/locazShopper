import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:locazshopper/constants/route_paths.dart';
import 'package:locazshopper/constants/strings.dart';
import 'package:locazshopper/db/models/product.dart';
import 'package:locazshopper/ui/custom_views/custom_naivigation_button.dart';
import 'package:locazshopper/ui/shared/base_widget.dart';
import 'package:locazshopper/utils/common_utils.dart';
import 'package:locazshopper/viewmodels/product/product_model.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  final String documentId;

  const ProductScreen({Key key, this.documentId}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProductModel>(
      model: ProductModel(),
      onModelReady: (model) => model.getProductsList(widget.documentId),
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text('search'),
            ),
            body: SafeArea(
                child: Column(
              children: <Widget>[
                (model?.productList?.length ?? 0) > 0
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: model?.productList?.length ?? 0,
                        itemBuilder: (context, index) {
                          Product product = model?.productList[index] ?? "";
                          return ProductItemCard(
                            product: product,
                            ownerId: widget.documentId,
                          );
                        })
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(32, 32, 32, 60),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                Visibility(
                  visible: (model?.cartList?.length ?? 0) > 0 ? true : false,
                  child: Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CustomNavigationButton(
                        title: goToMyOrderTxt.toUpperCase(),
                        widthFactor: 1,
                        onPressed: () {
                          navigateToWithArg(
                              context, RoutePaths.placeOrderScreen,
                              dynamicValue: model.cartList);
                        },
                      )
                    ],
                  )),
                )
              ],
            )));
      },
    );
  }

  List<DropdownMenuItem<Brand>> buildDropDownBrandItems(List<Brand> brands) {
    List<DropdownMenuItem<Brand>> items = List();
    brands.map((brand) {
      items.add(DropdownMenuItem(
        child: Text(brand.name),
        value: brand,
      ));
    }).toList();
    return items;
  }
}

class ProductItemCard extends StatefulWidget {
  final Product product;
  final String ownerId;

  const ProductItemCard({Key key, this.product, this.ownerId})
      : super(key: key);

  @override
  _ProductItemCardState createState() => _ProductItemCardState();
}

class _ProductItemCardState extends State<ProductItemCard> {
  List<DropdownMenuItem<Company>> _dropdownMenuQuantityItems = List();
  List<DropdownMenuItem<Company>> _dropdownMenuBrandItems = List();
  Company _selectedCompany;
  Company _selectedBrand;
  bool isAddItem = false;
  bool isAddItemEnable = true;

  @override
  void initState() {
    List<Company> _quantity = Company.getQuantities();
    List<Company> _brands = getBrandList(widget.product.brands);
    _dropdownMenuQuantityItems = buildDropdownMenuItems(_quantity);
    _dropdownMenuBrandItems = buildDropdownMenuItems(_brands);
    _selectedCompany = _dropdownMenuQuantityItems[0].value;
    _selectedBrand = _dropdownMenuBrandItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = List();
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(Company selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  onChangeDropdownBrandItem(Company selectedCompany) {
    setState(() {
      _selectedBrand = selectedCompany;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductModel model = Provider.of<ProductModel>(context);
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              widget.product?.itemName ?? '',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Quantity'),
                      Text('Brand'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DropdownButton(
                        value: _selectedCompany,
                        items: _dropdownMenuQuantityItems,
                        onChanged: onChangeDropdownItem,
                      ),
                      DropdownButton(
                        hint: Text('select Brand'),
                        value: _selectedBrand,
                        items: _dropdownMenuBrandItems,
                        onChanged: onChangeDropdownBrandItem,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomNavigationButton(
                          enabled: isAddItemEnable,
                          onPressed: () {
                            CartItem item = CartItem(
                                widget.ownerId,
                                widget.product.reference.documentID,
                                _selectedBrand.name,
                                _selectedCompany.name,
                                widget.product);
                            if (!isAddItem)
                              model.addItem(item);
                            else
                              model.removeItem(item);
                            setState(() {
                              isAddItemEnable = !isAddItemEnable;
                              isAddItem = !isAddItem;
                            });
                          },
                          title: isAddItem
                              ? 'Remove item'.toUpperCase()
                              : 'ADD ITEM',
                          width: 120,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            leading: CachedNetworkImage(
              fit: BoxFit.scaleDown,
              imageUrl: widget.product?.img ??
                  'https://via.placeholder.com/150?text= ',
              placeholder: (context, url) => CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          )
        ],
      ),
    );
  }

  List<Company> getBrandList(List<Brand> brands) {
    List<Company> companyList = List();
    int count = 1;
    try {
      brands.forEach((brand) {
        companyList.add(Company(count, brand.name));
        count = count + 1;
      });
    } catch (e, s) {
      print(s);
    }
    return companyList;
  }
}

class UserProductData {
  String ownerId;
  Product product;
  int quantityCount;

  UserProductData({this.ownerId, this.product, this.quantityCount});
}

class CartItem {
  String ownerId;
  String productId;
  String brand;
  String quantity;
  Product productDetails;

  CartItem(this.ownerId, this.productId, this.brand, this.quantity,
      this.productDetails);
}
