import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:ecommerce_int2/screens/shop/order_success.dart';
import 'package:ecommerce_int2/screens/shop/webxpay_payment_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../change_notifiers/cart_notifiers.dart';
import '../../models/cart.dart';

class ConfirmYourOrderPage extends StatefulWidget {
  @override
  _ConfirmYourOrderPageState createState() => _ConfirmYourOrderPageState();
}

class _ConfirmYourOrderPageState extends State<ConfirmYourOrderPage> {

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    cartNotifier.calculateOrderInfo();

    return Material(
        color: Colors.white,
        child: SafeArea(
          child: LayoutBuilder(
              builder: (_, constraints) => SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: kToolbarHeight),
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Confirm your order (3/3)',
                                    style: TextStyle(
                                      color: darkGrey,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CloseButton()
                                ],
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.all(16.0),
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 16, 16.0, 16.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: shadow,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10))),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Table(
                                          columnWidths: const <int,
                                              TableColumnWidth>{
                                            0: FixedColumnWidth(120.0),
                                            1: FixedColumnWidth(80.0),
                                            2: FixedColumnWidth(100.0),
                                          },
                                          children: List<TableRow>.generate(
                                              cartNotifier.cart!.line_items.length,
                                              (index) {
                                            CartItem item =
                                                cartNotifier.cart!.line_items[index];
                                            return TableRow(
                                              children: <Widget>[
                                                TableCell(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    // Space between rows
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(item.name),
                                                          // First line
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                      child: Text(
                                                          '${NumberFormat('#,##0.00', 'en_US').format(item.salePrice)} x ${item.quantity}')),
                                                ),
                                                TableCell(
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          '${NumberFormat('#,##0.00', 'en_US').format(item.salePrice*item.quantity)}',
                                                        ),
                                                        // First line
                                                        Text(
                                                          'Discount (-${NumberFormat('#,##0.00', 'en_US').format(item.salePrice*item.quantity*item.linediscount/100)})',
                                                          style: TextStyle(
                                                              fontSize: 10.0,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                        // Second line with smaller font
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }))
                                    ])),
                            Container(
                              margin: const EdgeInsets.all(16.0),
                              padding: const EdgeInsets.fromLTRB(
                                  16.0, 0, 16.0, 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: shadow,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10))),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Table(
                                    columnWidths: const <int, TableColumnWidth>{
                                      0: FixedColumnWidth(150.0),
                                      2: FixedColumnWidth(60.0),
                                    },
                                    children: <TableRow>[
                                      // First Row
                                      // Second Row
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              // Space between rows
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Total line discounts',
                                                  ),
                                                  // First line
                                                  // Second line with smaller font
                                                ],
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '-${cartNotifier.totalLineDiscounts}',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  // Second line with smaller font
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              // Space between rows
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Total (before discount)',
                                                  ),
                                                  // First line
                                                  // Second line with smaller font
                                                ],
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '${cartNotifier.totalBeforeDiscounts}',
                                                    textAlign: TextAlign.left,
                                                  ), // First line
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              // Space between rows
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Discount on Total',
                                                  ),
                                                  // First line
                                                  // Second line with smaller font
                                                ],
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Text(
                                                    '${cartNotifier.discountOnTotal}',
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ), // First line
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              // Space between rows
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Shipping',
                                                  ),
                                                  // First line
                                                  // Second line with smaller font
                                                ],
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '${cartNotifier.shipping_charges}',
                                                    textAlign: TextAlign.left,
                                                  ), // First line
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      TableRow(
                                        children: <Widget>[
                                          TableCell(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              // Space between rows
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Total',
                                                  ),
                                                  // First line
                                                  // Second line with smaller font
                                                ],
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    '${cartNotifier.total}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ), // First line
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ActionButton(
                                buttonType: ButtonType.enabled_default,
                                buttonText: 'Confirm',
                                onTap: ()  {
                                  Utils.showToast("Placing your order", ToastType.in_progress);
                                  cartNotifier.createOrder().then((value) {
                                    CartAPIs.clearTheCart().then((value) {
                                      if (value.status == true){
                                        print("cart is cleared");
                                      }
                                    });
                                    Utils.showToast("Your order is confirmed.", ToastType.done_success);
                                      // ScaffoldMessenger.of(context).showSnackBar(
                                      //   SnackBar(
                                      //     content: Text(value?'Order created':"Error: Order creation"),
                                      //     duration: Duration(seconds: 2), // Duration for how long the snackbar is visible
                                      //   ),
                                      // );
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (_) => Checkout(receiptNumber: "")));
                                  }
                                  );
                                },
                              ),
                            )
                          ]))))),
        ));
  }
}
