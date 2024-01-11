import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_int2/api_services/woocommerce_api.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/models/cart.dart';
import 'package:ecommerce_int2/screens/address/add_address_page.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:ecommerce_int2/screens/payment/unpaid_page.dart';
import 'package:ecommerce_int2/screens/shop/components/shop_item_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatelessWidget {
  SwiperController swiperController = SwiperController();

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: true);
    return Container(
      child: FutureBuilder<Cart?>(
        future: cartNotifier.getCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the API call
            return Center(
              child: CircularProgressIndicator(), // Or any other loader widget
            );
          }

          final cart = snapshot.data;
          if (cart != null) {
            cartNotifier.loadProduct(cart);
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                iconTheme: IconThemeData(color: THEME_COLOR_1),
                actions: <Widget>[
                  IconButton(
                    icon: Image.asset('assets/icons/denied_wallet.png'),
                    onPressed: () => Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
                  )
                ],
                title: Text(
                  'My Cart',
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
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          height: screenAwareSize(24, context),
                          color: PAGE_BACKGROUND_COLOR,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Subtotal (Before discount): Rs ' +
                                    Utils.thousandSeperate(cartNotifier.cart!
                                        .getTotalBeforeDiscount()
                                        .toString()) +
                                    "/=",
                                style: TextStyle(
                                    color: CONTENT_TEXT_COLOR_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              Text(
                                "(" +
                                    cart!.line_items.length.toString() +
                                    ' items)',
                                style: TextStyle(
                                    color: CONTENT_TEXT_COLOR_1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenAwareSize(80, context),
                          width: screenAwareWidth(72, context),
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              itemBuilder: (_, index) => cart == null
                                  ? Container()
                                  : ShopItemList(
                                      cartNotifier.cart!.line_items[index],
                                      onRemove: () {
                                        cartNotifier.cart!.line_items
                                            .remove(cart!.line_items[index]);
                                      },
                                    ),
                              itemCount: cartNotifier.cart!.line_items.length,
                            ),
                          ),
                        ),
                        SizedBox(
                            height: screenAwareSize(15, context),
                            child:
                                Container() // display the subtotal, total item count here
                            ),
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).padding.bottom == 0
                                  ? 20
                                  : MediaQuery.of(context).padding.bottom),
                          child: ActionButton(
                            buttonType: ButtonType.enabled_default,
                            buttonText: 'Checkout',
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => AddAddressPage()));
                            },
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            // After reading from storage, use the data to build your widget
            return Container();
          }
        },
      ),
    );
  }
}

class Scroll extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    
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
