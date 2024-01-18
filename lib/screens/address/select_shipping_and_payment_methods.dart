import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:ecommerce_int2/screens/shop/order_confirmation.dart';
import 'package:ecommerce_int2/screens/payment/unpaid_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../shop/components/credit_card.dart';

class SelectShippingMethodPage extends StatefulWidget {
  User? user;
  SelectShippingMethodPage({required this.user});
  @override
  _SelectShippingMethodPageState createState() =>
      _SelectShippingMethodPageState();
}

class _SelectShippingMethodPageState extends State<SelectShippingMethodPage> {
  SwiperController swiperController = SwiperController();

  List<SwipeSelectItem> payment_methods = [
    SwipeSelectItem(
      title: "Cash",
      tag: "cash",
      icon: Icon(
        Icons.payments,
        size: 36, // Adjust the size of the icon
        color: Colors.white,
      ),
      color: Colors.green.shade300,
    ),
    // SwipeSelectItem(title: "Card",tag: "cc", icon: Icon(
    //     Icons.credit_card,
    //     size: 36, // Adjust the size of the icon
    //     color: Colors.white,
    //   ),
    //   color: Colors.blue
    //   ),
    SwipeSelectItem(
        title: "Card payment on delivery",
        tag: "card_on_delivery",
        icon: Icon(
          Icons.credit_card,
          size: 36, // Adjust the size of the icon
          color: Colors.white,
        ),
        color: Colors.blue),
    SwipeSelectItem(
        title: "Bank Transfer",
        tag: "bt",
        icon: Icon(
          Icons.credit_card,
          size: 36, // Adjust the size of the icon
          color: Colors.white,
        ),
        color: Colors.grey),
  ];

  List<SwipeSelectItem> shipping_methods = [
    SwipeSelectItem(
      title: "Door delivery",
      tag: "dd",
      icon: Icon(
        Icons.payments,
        size: 36, // Adjust the size of the icon
        color: Colors.white,
      ),
      color: Colors.orange,
    ),
    SwipeSelectItem(
        title: "Store pickup",
        tag: "sp",
        icon: Icon(
          Icons.credit_card,
          size: 36, // Adjust the size of the icon
          color: Colors.white,
        ),
        color: Colors.black87),
  ];

  @override
  Widget build(BuildContext context) {

    return Consumer<CartNotifier>(builder: (context, cartNotifier, _) {
          cartNotifier.calculateOrderInfo(widget.user);

      return cartNotifier.cart == null
          ? Container()
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: IconThemeData(color: darkGrey),
                actions: <Widget>[
                  // IconButton(
                  //   icon: Image.asset('assets/icons/denied_wallet.png'),
                  //   onPressed: () => Navigator.of(context)
                  //       .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
                  // )
                ],
                title: Text(
                  'Shipping & Payments (2/3)',
                  style: TextStyle(
                      color: darkGrey,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                ),
              ),
              body: LayoutBuilder(
                builder: (_, constraints) => SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Select Payment method : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: darkGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                child: Swiper(
                                  itemCount: payment_methods.length,
                                  itemBuilder: (_, index) {
                                    return payment_methods[index];
                                  },
                                  scale: 0.8,
                                  controller: swiperController,
                                  viewportFraction: 0.6,
                                  loop: false,
                                  fade: 0.7,
                                  onIndexChanged: (index) {
                                    cartNotifier.updatePayentMethod(widget.user,
                                        payment_methods[index].tag,
                                        payment_methods[index].title);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Text(
                                  'Select Shipping method : ',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: darkGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 120,
                                child: Swiper(
                                  itemCount: shipping_methods.length,
                                  itemBuilder: (_, index) {
                                    return shipping_methods[index];
                                  },
                                  scale: 0.8,
                                  controller: swiperController,
                                  viewportFraction: 0.6,
                                  loop: false,
                                  fade: 0.7,
                                  onIndexChanged: (index) {
                                    cartNotifier.updateShippingMethod(widget.user,shipping_methods[index].tag);
                                  },
                                ),
                              ),
                              SizedBox(height: 24),
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
                                      columnWidths: const <int,
                                          TableColumnWidth>{
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
                                                    vertical:
                                                        5), // Space between rows
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Bill amount',
                                                    ), // First line
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
                                                      '-${NumberFormat('#,##0.00', 'en_US').format((cartNotifier.totalBeforeDiscounts - cartNotifier.totalLineDiscounts))}',
                                                      textAlign: TextAlign.left,
                                                    ), // Second line with smaller font
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
                                                    vertical:
                                                        5), // Space between rows
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                        'Payment method discount (%)')
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
                                                      cartNotifier.payment_method_discount_percentage >
                                                              0
                                                          ? cartNotifier
                                                                  .payment_method_discount_percentage
                                                                  .toString() +
                                                              "%"
                                                          : "n/a",
                                                      textAlign: TextAlign.left,
                                                    ) // First line
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
                                                    vertical:
                                                        5), // Space between rows
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text('Shipping charges')
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
                                                      cartNotifier.shipping_charges >
                                                              0
                                                          ? '${NumberFormat('#,##0.00', 'en_US').format(cartNotifier.shipping_charges)}'
                                                          : "n/a",
                                                      textAlign: TextAlign.left,
                                                    ) // First line
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
                                                    vertical:
                                                        5), // Space between rows
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Discount amount',
                                                    ), // First line
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
                                                      cartNotifier.discountOnTotal >
                                                              0
                                                          ? '-${NumberFormat('#,##0.00', 'en_US').format(cartNotifier.discountOnTotal)}'
                                                          : "n/a",
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
                                                    vertical:
                                                        5), // Space between rows
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Total payable',
                                                    ), // First line
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
                                                      '-${NumberFormat('#,##0.00', 'en_US').format(cartNotifier.total)}',
                                                      textAlign: TextAlign.left,
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
                              Center(
                                  child: Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom ==
                                                0
                                            ? 20
                                            : MediaQuery.of(context)
                                                .padding
                                                .bottom),
                                child: ActionButton(
                                  buttonType: ButtonType.enabled_default,
                                  buttonText: 'Next',
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ConfirmYourOrderPage(user: widget.user)));
                                  },
                                ),
                              ))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            );
    });
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    LinearGradient grT = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
    LinearGradient grB = LinearGradient(
        colors: [Colors.transparent, Colors.black26],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter);

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, 30),
        Paint()
          ..shader = grT.createShader(Rect.fromLTRB(0, 0, size.width, 30)));

    canvas.drawRect(Rect.fromLTRB(0, 30, size.width, size.height - 40),
        Paint()..color = Color.fromRGBO(50, 50, 50, 0.4));

    canvas.drawRect(
        Rect.fromLTRB(0, size.height - 40, size.width, size.height),
        Paint()
          ..shader = grB.createShader(
              Rect.fromLTRB(0, size.height - 40, size.width, size.height)));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
