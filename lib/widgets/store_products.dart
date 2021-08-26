import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uni_match/app/app_controller.dart';
import 'package:uni_match/app/models/app_model.dart';
import 'package:uni_match/app/models/user_model.dart';

import 'my_circular_progress.dart';

class StoreProducts extends StatefulWidget {
  final Widget icon;
  final Color priceColor;

  StoreProducts({required this.icon, required this.priceColor});

  @override
  _StoreProductsState createState() => _StoreProductsState();
}

class _StoreProductsState extends State<StoreProducts> {
  // Variables
  bool _storeIsAvailable = false;
  List<ProductDetails>? _products;
  AppController _i18n = Modular.get();

  @override
  void initState() {
    super.initState();

    InAppPurchase.instance.isAvailable().then((result) {
    // InAppPurchaseConnection.instance.isAvailable().then((result) {
      if (mounted)
        setState(() {
          _storeIsAvailable =
              result; // if false the store can not be reached or accessed
        });
    });

    /// Ultima versao
    // Check google play services // Ultima versao
    // InAppPurchase.instance.isAvailable().then((result) {
    //   if (mounted)
    //     setState(() {
    //       _storeIsAvailable =
    //           result; // if false the store can not be reached or accessed
    //     });
    // });
    //
    // // Get product subscriptions from google play store / apple store
    // InAppPurchase.instance
    //     .queryProductDetails(AppModel().appInfo.subscriptionIds.toSet())
    //     .then((ProductDetailsResponse response) {


    // InAppPurchaseConnection.instance
    InAppPurchase.instance
        .queryProductDetails(AppModel().appInfo.subscriptionIds.toSet())
        .then((ProductDetailsResponse response) {

      /// Update UI
      if (mounted)
        setState(() {
          // Get product list
          _products = response.productDetails;
          // Check result
          if (_products!.isNotEmpty) {
            // Order by price ASC
            _products!.sort((a, b) => a.price.compareTo(b.price));
          }
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _storeIsAvailable ? _showProducts() : _storeNotAvailable();
  }

  Widget _showProducts() {
    if (_products == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyCircularProgress(),
              SizedBox(height: 5),
              Text(_i18n.translate("processing")!,
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
              Text(_i18n.translate("please_wait")!,
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center)
            ],
          ),
        ),
      );
    } else if (_products!.isNotEmpty) {
      // Show Subscriptions
      return ScopedModelDescendant<UserModel>(
          builder: (context, child, userModel) {
        return Column(
            children: _products!.map<Widget>((item) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              enabled: userModel.activeVipId == item.id ? false : true,
              leading: widget.icon,
              title: Text(item.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(item.price,
                  style: TextStyle(
                      fontSize: 19,
                      color: widget.priceColor,
                      fontWeight: FontWeight.bold)),
              trailing: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.all(8)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          userModel.activeVipId == item.id
                              ? Colors.grey
                              : widget.priceColor),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ))),
                  child: userModel.activeVipId == item.id
                      ? Text(_i18n.translate("ACTIVE")!,
                          style: TextStyle(color: Colors.white))
                      : Text(_i18n.translate("SUBSCRIBE")!,
                          style: TextStyle(color: Colors.white)),
                  onPressed: userModel.activeVipId == item.id
                      ? null
                      : () async {
                          // Purchase parameters
                          final pParam = PurchaseParam(
                            productDetails: item,
                          );
                          // InAppPurchaseConnection.instance
                          //     .buyNonConsumable(purchaseParam: pParam);

                          /// Subscribe - > Ultima versão
                          InAppPurchase.instance
                              .buyNonConsumable(purchaseParam: pParam);
                        }),
            ),
          );
        }).toList());
      });
    } else {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.search,
                  size: 80, color: Theme.of(context).primaryColor),
              Text(_i18n.translate("no_products_or_subscriptions")!,
                  style: TextStyle(fontSize: 18), textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }
  }

  Widget _storeNotAvailable() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error_outline,
              size: 80, color: Theme.of(context).primaryColor),
          Text(_i18n.translate("oops_an_error_has_occurred")!,
              style: TextStyle(fontSize: 18.0), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
