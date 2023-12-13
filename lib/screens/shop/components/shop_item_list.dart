import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/models/cart.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/components/color_list.dart';
import 'package:ecommerce_int2/screens/product/components/shop_product.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

import '../../../change_notifiers/product_notifier.dart';

//
// class ShopItemList extends StatefulWidget {
//
//   @override
//   _ShopItemListState createState() => _ShopItemListState();
// }

class ShopItemList extends StatelessWidget {
  final CartItem cart_item;
  final VoidCallback onRemove;

  ShopItemList(this.cart_item, {required this.onRemove});

  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context, listen: false);
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context, listen: false);

    return FutureBuilder<Product?>(
        future: productNotifier.getProduct(this.cart_item.id),
        builder: (context, snapshot) {
          return Container(
            margin: EdgeInsets.only(top: 20),
            height: 130,
            child: Stack(
              children: <Widget>[
                Container(
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: shadow,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ShopProductDisplay(
                              onPressed: () => {},
                              car_item: this.cart_item,
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 12.0, right: 0.0),
                              width: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    this.cart_item.name,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: darkGrey,
                                    ),
                                  ), // Product name
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      width: 160,
                                      padding: const EdgeInsets.only(
                                          left: 32.0, top: 8.0, bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '\Rs. ${this.cart_item.salePrice}',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: darkGrey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12.0),
                                          )
                                        ],
                                      ),
                                    ),
                                  ) // Option & Price
                                ],
                              ),
                            ),

                            Theme(
                                data: ThemeData(
                                    //accentColor: Colors.black,
                                    textTheme: TextTheme(
                                  headline6: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  bodyText1: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    color: Colors.grey[400],
                                  ),
                                )),
                                child: NumberPicker(
                                    value: cart_item.quantity,
                                    minValue: 1,
                                    maxValue: 10,
                                    onChanged: (value) {
                                      cartNotifier.updateLineItemQuantity(cart_item.id, value);
                                    }))
                          ])),
                // TODO:

              ],
            ),
          );
        });
  }
}
