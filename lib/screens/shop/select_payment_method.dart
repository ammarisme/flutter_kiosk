import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/screens/address/add_address_page.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:ecommerce_int2/screens/shop/order_confirmation.dart';
import 'package:ecommerce_int2/screens/payment/unpaid_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'components/credit_card.dart';
import 'components/shop_item_list.dart';

class SelectPaymentMethodPage extends StatefulWidget {
  @override
  _SelectPaymentMethodPageState createState() =>
      _SelectPaymentMethodPageState();
}

class _SelectPaymentMethodPageState extends State<SelectPaymentMethodPage> {
  SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);

    List<dynamic> payment_methods = [
      Cash(),
      CreditCard(),
      CreditCard()
    ];
    cartNotifier.calculateOrderInfo();

    return Consumer<CartNotifier>(builder: (context, productNotifier, _) {

      return cartNotifier.cart == null
          ? Container()
          : Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: darkGrey),
          actions: <Widget>[
            IconButton(
              icon: Image.asset('assets/icons/denied_wallet.png'),
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
            )
          ],
          title: Text(
            'Checkout',
            style: TextStyle(
                color: darkGrey,
                fontWeight: FontWeight.w500,
                fontSize: 18.0),
          ),
        ),
        body: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints:
              BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Payment',
                      style: TextStyle(
                          fontSize: 20,
                          color: darkGrey,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 250,
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
                      onIndexChanged: (index) => {
                        cartNotifier.updatePayentMethod(payment_methods[index].payment_method,
                            payment_methods[index].payment_method_title)
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
                                  child:
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5), // Space between rows
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Bill amount',
                                        ), // First line
                                        // Second line with smaller font
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
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
                                  child:
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5), // Space between rows
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Payment method discount (%)'
                                        )
                                        // Second line with smaller font
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          cartNotifier.payment_method_discount_percentage > 0 ?
                                          cartNotifier.payment_method_discount_percentage.toString() + "%" : "n/a",
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
                                  child:
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5), // Space between rows
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      children: <Widget>[
                                        Text('Discount amount',
                                        ), // First line
                                        // Second line with smaller font
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          cartNotifier.discountOnTotal > 0 ?
                                          '-${NumberFormat('#,##0.00', 'en_US').format(cartNotifier.discountOnTotal)}' : "n/a",
                                          style: TextStyle(
                                              color: Colors.red),
                                        )
                                        , // First line
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            TableRow(
                              children: <Widget>[
                                TableCell(
                                  child:
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5), // Space between rows
                                    child:  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Total payable',
                                        ), // First line
                                        // Second line with smaller font
                                      ],
                                    ),
                                  ),
                                ),
                                TableCell(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
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
                            bottom: MediaQuery.of(context).padding.bottom == 0
                                ? 20
                                : MediaQuery.of(context).padding.bottom),
                        child: ActionButton(
                          buttonText: 'Next',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ConfirmYourOrderPage()));
                          },
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    });  }
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
