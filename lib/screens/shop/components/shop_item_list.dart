import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/models/cart.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/components/shop_product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../change_notifiers/product_notifier.dart';

//
class ShopItemList extends StatefulWidget {
  final CartItem cart_item;
  final VoidCallback onRemove;
  ShopItemList(this.cart_item, {required this.onRemove});

  @override
  _ShopItemListState createState() => _ShopItemListState();
}

class _ShopItemListState extends State<ShopItemList> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: true);

    textEditingController.text = widget.cart_item.quantity.toString();

    return FutureBuilder<Product?>(
        future: productNotifier.getProduct(widget.cart_item.product_id),
        builder: (context, snapshot) {
          widget.cart_item.product = snapshot.data;
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
                            car_item: widget.cart_item,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 12.0, right: 0.0),
                            width: 150,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  widget.cart_item.name,
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
                                          '\Rs. ${widget.cart_item.salePrice}',
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
                         GestureDetector(
                                      onTap: () {
                                        print("test");
                                        if (widget.cart_item.product!
                                                .stock_quantity >
                                            0) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              int quantity = widget.cart_item.quantity;
                                              TextEditingController
                                                  quantityController =
                                                  TextEditingController(
                                                      text:quantity.toString() );

                                              void incrementQuantity() {
                                                setState(() {
                                                  if (quantity + 1 >
                                                      widget.cart_item.product!
                                                          .stock_quantity) {
                                                    quantity = widget
                                                        .cart_item
                                                        .product!
                                                        .stock_quantity;
                                                  } else {
                                                    quantity++;
                                                    quantityController.text =
                                                        quantity.toString();
                                                  }
                                                });
                                              }

                                              void decrementQuantity() {
                                                if (quantity > 1) {
                                                  setState(() {
                                                    quantity--;
                                                    quantityController.text =
                                                        quantity.toString();
                                                  });
                                                }
                                              }

                                              return AlertDialog(
                                                title: Text('Update quantity'),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Text(
                                                        '(Max : ${widget.cart_item.product!.stock_quantity})'),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        IconButton(
                                                          icon: Icon(
                                                              Icons.remove),
                                                          onPressed:
                                                              decrementQuantity,
                                                        ),
                                                        SizedBox(width: 20),
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                quantityController,
                                                            textAlign: TextAlign
                                                                .center,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            onChanged: (value) {
                                                              quantity =
                                                                  int.tryParse(
                                                                          value) ??
                                                                      1;
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(width: 20),
                                                        IconButton(
                                                          icon: Icon(Icons.add),
                                                          onPressed:
                                                              incrementQuantity,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      // Add item to cart with the selected quantity
                                                      Utils.showToast(
                                                          "Adding ${quantity} ${widget.cart_item.product!.name} to your cart.",
                                                          ToastType
                                                              .done_success);

                                                          if (widget.cart_item.product!.stock_quantity ==
                                                              widget.cart_item.quantity) {
                                                            print("not enough stocks");
                                                            return;
                                                          }
                                                          CartAPIs.updateMyCartItemByKey(
                                                                  key: widget.cart_item.key,
                                                                  id: widget.cart_item.product_id,
                                                                  quantity: quantity)
                                                              .then((updated) {
                                                            if (updated) {
                                                              widget.cart_item.quantity = quantity;
                                                              textEditingController.text = (quantity).toString();
                                                              setState(() {
                                                                widget.cart_item.quantity = quantity;
                                                              });
                                                            }
                                                          });
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Text('Update'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: Text('Cancel'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: Container(
                              width: screenAwareWidth(15, context),
                              child: 
                              Container(
                                 decoration: BoxDecoration(
    color: Colors.grey.shade100,
  ),
                                child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.all(5), child: Text("X "+ widget.cart_item.quantity.toString())),
                                  Padding(padding: EdgeInsets.only(left: 5, right: 5, top: 7, bottom:5), child: Icon(Icons.edit, size: 16,))
                                  
                                  //  TextField(
                                  //       readOnly: true,
                                  //       controller: textEditingController,
                                  //       maxLength: 2,
                                  //       style: TextStyle(
                                  //           fontSize:
                                  //               14.0), // Change the font size here
                                  //       textAlign: TextAlign.center,
                                  //       decoration: InputDecoration(
                                  //           isDense:
                                  //               true, // Reduces the height of the TextField

                                  //           counterText:
                                  //               '', // Remove default character counter
                                  //           contentPadding: EdgeInsets.symmetric(
                                  //               vertical: 0.0,
                                  //               horizontal:
                                  //                   2), // Adjust vertical padding
                                  //           focusedBorder: OutlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //                 width: 1.0,
                                  //                 color: Colors
                                  //                     .grey), // Border when focused
                                  //           ),
                                  //           enabledBorder: OutlineInputBorder(
                                  //             borderSide: BorderSide(
                                  //                 width: 1.0,
                                  //                 color: Colors
                                  //                     .grey), // Default border
                                  //           ),
                                  //           suffixIcon: Icon(Icons.edit)),
                                  //       keyboardType: TextInputType.number,
                                  //       onChanged: (value) {
                                  //         // Handle onChanged event if needed
                                  //       },
                                  //     )
                                ],
                              )
)
                                )
                              )
                        ])),
                // TODO:
              ],
            ),
          );
        });
  }
}
