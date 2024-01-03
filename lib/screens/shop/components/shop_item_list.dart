import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/models/cart.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/components/shop_product.dart';
import 'package:flutter/material.dart';
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
  TextEditingController textEditingController = TextEditingController();

  ShopItemList(this.cart_item, {required this.onRemove});

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: true);

    textEditingController.text = cart_item.quantity.toString();

    return FutureBuilder<Product?>(
        future: productNotifier.getProduct(this.cart_item.product_id),
        builder: (context, snapshot) {
          cart_item.product = snapshot.data;
          //textEditingController.text =  cartNotifier.cart!.line_items.where((cart_item) => cart_item.product_id == cart_item.product_id).first.quantity.toString();
          return Container(
            margin: EdgeInsets.only(top: 20),
            height: screenAwareSize(20, context),
            child: Stack(
              children: <Widget>[
                Container(
                    height: screenAwareSize(80, context),
                    margin: EdgeInsets.symmetric(horizontal: 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: shadow,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          Container(
                              padding: EdgeInsets.only(
                                  top: 10.0), // Add padding to the top

                              width: screenAwareWidth(10, context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                      onTap: () {
                                        // Your tap event handling logic goes here
                                        if (cart_item.product!.stock_quantity ==
                                            cart_item.quantity) {
                                          print("not enough stocks");
                                          return;
                                        }
                                        CartAPIs.updateMyCartItemByKey(
                                                key: cart_item.key,
                                                id: cart_item.product_id,
                                                quantity:
                                                    cart_item.quantity + 1,
                                                nonce: cartNotifier.cart!.nonce)
                                            .then((updated) {
                                          if (updated) {
                                            cart_item.quantity += 1;
                                            textEditingController.text =
                                                (cart_item.quantity).toString();
                                          }
                                        });
                                        // Add any other actions you want to perform on tap
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .grey, // Set the background color here
                                          shape: BoxShape
                                              .rectangle, // Adjust the shape as needed (circle, square, etc.)
                                        ),
                                        padding: EdgeInsets.all(
                                            0.0), // Adjust padding as needed
                                        margin: EdgeInsets.all(
                                            8.0), // Add margin here
                                        child: Icon(
                                          Icons.add,
                                          size: 14.0,
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 1), // Icon color
                                        ),
                                      )),
                                  TextField(
                                    readOnly: true,
                                    controller: textEditingController,
                                    maxLength: 2,
                                    style: TextStyle(
                                        fontSize:
                                            14.0), // Change the font size here

                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      isDense:
                                          true, // Reduces the height of the TextField

                                      counterText:
                                          '', // Remove default character counter
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical:
                                              0.0), // Adjust vertical padding
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.0,
                                            color: Colors
                                                .grey), // Border when focused
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1.0,
                                            color:
                                                Colors.grey), // Default border
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      // Handle onChanged event if needed
                                    },
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                         // Your tap event handling logic goes here
                                        if (cart_item.quantity == 1) {
                                          print("only 1 quantity");
                                          return;
                                        }
                                        CartAPIs.updateMyCartItemByKey(
                                                key: cart_item.key,
                                                id: cart_item.product_id,
                                                quantity:
                                                    cart_item.quantity -1 ,
                                                nonce: cartNotifier.cart!.nonce)
                                            .then((updated) {
                                          if (updated) {
                                            cart_item.quantity -= 1;
                                            textEditingController.text =
                                                (cart_item.quantity).toString();
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .grey, // Set the background color here
                                          shape: BoxShape
                                              .rectangle, // Adjust the shape as needed (circle, square, etc.)
                                        ),
                                        padding: EdgeInsets.all(
                                            0.0), // Adjust padding as needed
                                        margin: EdgeInsets.all(
                                            8.0), // Add margin here
                                        child: Icon(
                                          Icons.remove,
                                          size: 14.0,
                                          color: const Color.fromRGBO(
                                              0, 0, 0, 1), // Icon color
                                        ),
                                      )),
                                ],
                              ))
                        ])),
                // TODO:
              ],
            ),
          );
        });
  }
}
