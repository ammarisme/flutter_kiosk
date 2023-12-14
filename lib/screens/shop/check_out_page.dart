import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/screens/address/add_address_page.dart';
import 'package:ecommerce_int2/screens/payment/unpaid_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/ui_components.dart';
import 'components/shop_item_list.dart';


class CheckOutPage extends StatelessWidget {

 SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
    Provider.of<CartNotifier>(context, listen: false);
    cartNotifier.getCart();

    return Consumer<CartNotifier>(
        builder: (context, productNotifier, _) {
          return cartNotifier.cart == null ? Container() :
          Scaffold(
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
                    color: darkGrey, fontWeight: FontWeight.w500, fontSize: 18.0),
              ),
            ),
            body: LayoutBuilder(
              builder: (_, constraints) => SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32.0),
                        height: 48.0,
                        color: yellow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              cartNotifier.cart!.line_items.length.toString() + ' items',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 600,
                        child: Scrollbar(
                          child: ListView.builder(
                            itemBuilder: (_, index) => ShopItemList(
                              cartNotifier.cart!.line_items[index],
                              onRemove: () {
                                  cartNotifier.cart!.line_items.remove(cartNotifier.cart!.line_items[index]);
                              },
                            ),
                            itemCount: cartNotifier.cart!.line_items.length,
                          ),
                        ),
                      ),

                      SizedBox(height: 24),
                      Center(
                          child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).padding.bottom == 0
                                ? 20
                                : MediaQuery.of(context).padding.bottom),
                        child: ActionButton(
                          buttonText: 'Checkout',
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddAddressPage()));
                          },
                        ),
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );



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
