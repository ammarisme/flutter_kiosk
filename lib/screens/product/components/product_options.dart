import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../change_notifiers/cart_notifiers.dart';
import 'shop_bottomSheet.dart';

class ProductOption extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Product product;
  const ProductOption(
    this.scaffoldKey, {
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
    Provider.of<CartNotifier>(context, listen: false);

    return SizedBox(
      height: 450,
      child: Stack(
        children: <Widget>[
            Positioned(
              left: 10,
              top:10,
              width: MediaQuery.of(context).size.width / 1.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              width: MediaQuery.of(context).size.width / 1.4,
              top: 20,
              left: 20,
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  product.name,
                  
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
            right: 0.0,
            top:10,
            child: Container(
              height: 130,
              width: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => CheckOutPage()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / MAIN_BUTTON_FACTOR,
                      decoration: BoxDecoration(
                          color: BUTTON_COLOR_1,
                          gradient: MAIN_BUTTON_GRADIENTS,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Icon(
                                Icons.shopping_bag,
                                color: BUTTON_TEXT_COLOR1, // Set icon color as needed
                                size:BUTTON_ICON_SIZE
                              ),
                              SizedBox(width: 3), // Adjust the space between text and icon
                              Text(
                                'Buy Now',
                                style: TextStyle(
                                  color: BUTTON_TEXT_COLOR1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: BUTTON_FONT_SIZE,
                                ),
                              ),
                              
                            ],
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if(product.stock_quantity>0){
                        print(cartNotifier.cart?.nonce);
                        cartNotifier.addItem(product.id,1, cartNotifier.cart?.nonce);
                        // scaffoldKey.currentState!.showBottomSheet((context) {
                        //   cartNotifier.addItem(16652,1, cartNotifier.cart?.nonce);
                        //   return ShopBottomSheet();
                        // });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / MAIN_BUTTON_FACTOR,
                      decoration: BoxDecoration(
                          color: product.stock_quantity>0?BUTTON_COLOR_1:BUTTON_COLOR_1_INACTIVE,
                          gradient: MAIN_BUTTON_GRADIENTS,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                       child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: BUTTON_TEXT_COLOR1, // Set icon color as needed
                                size:BUTTON_ICON_SIZE
                              ),
                              SizedBox(width: 3),
                              Text(
                                product.stock_quantity>0?'Add to cart' : 'Out of stock',
                                style: TextStyle(
                                  color: BUTTON_TEXT_COLOR1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: BUTTON_FONT_SIZE,
                                ),
                              ),
                               // Adjust the space between text and icon
                            ],
                          ),
                    ),
                  )
,
                 
                ],
              ),
            ),
          ),
            Positioned(
          top : 370,
          left:10,
          child: Container(
              height: 100,
              width: 300,
              child : Row(
                  children : [
Container(
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                          color: Colors.black, // Set border color to black
                          width: 1.0, // Set border width
                        ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                       child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Brand: " + product.brand_name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: BUTTON_FONT_SIZE,
                                ),
                              ),
                               // Adjust the space between text and icon
                            ],
                          ),
                    )
                    ,
                    SizedBox(width:5),
                    (product.weight == null) ? Container() :
                      Container(
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                          color: Colors.black, // Set border color to black
                          width: 1.0, // Set border width
                        ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                       child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Weight: " + product.weight+"kg",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: BUTTON_FONT_SIZE,
                                ),
                              ),
                               // Adjust the space between text and icon
                            ],
                          ),
                    )
                  ]
                )
          )

        )
        ],
      ),
    );
  }
}
