import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/address/address_form.dart';
import 'package:ecommerce_int2/screens/address/select_shipping_method.dart';
import 'package:ecommerce_int2/screens/select_card_page.dart';
import 'package:ecommerce_int2/screens/shop/select_payment_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../change_notifiers/cart_notifiers.dart';
import '../components/ui_components.dart';

class AddAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        title: Text(
          'Checkout',
          style: const TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).padding.bottom == 0
                      ? 20
                      : MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Card(
                      //     margin: EdgeInsets.symmetric(vertical: 8.0),
                      //     color: Colors.white,
                      //     elevation: 3,
                      //     child: SizedBox(
                      //         height: 100,
                      //         width: 80,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: <Widget>[
                      //               Padding(
                      //                 padding: const EdgeInsets.all(4.0),
                      //                 child: Image.asset(
                      //                     'assets/icons/address_home.png'),
                      //               ),
                      //               Text(
                      //                 'Add New Address',
                      //                 style: TextStyle(
                      //                   fontSize: 8,
                      //                   color: darkGrey,
                      //                 ),
                      //                 textAlign: TextAlign.center,
                      //               )
                      //             ],
                      //           ),
                      //         ))),
                      // Add a new address
                      // Card(
                      //     margin: EdgeInsets.symmetric(vertical: 8.0),
                      //     color: yellow,
                      //     elevation: 3,
                      //     child: SizedBox(
                      //         height: 80,
                      //         width: 100,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: <Widget>[
                      //               Padding(
                      //                 padding: const EdgeInsets.all(4.0),
                      //                 child: Image.asset(
                      //                   'assets/icons/address_home.png',
                      //                   color: Colors.white,
                      //                   height: 20,
                      //                 ),
                      //               ),
                      //               Text(
                      //                 'Home',
                      //                 style: TextStyle(
                      //                   fontSize: 8,
                      //                   color: Colors.white,
                      //                 ),
                      //                 textAlign: TextAlign.center,
                      //               )
                      //             ],
                      //           ),
                      //         ))), // Address 1
                      // Card(
                      //     margin: EdgeInsets.symmetric(vertical: 8.0),
                      //     color: yellow,
                      //     elevation: 3,
                      //     child: SizedBox(
                      //         height: 80,
                      //         width: 100,
                      //         child: Padding(
                      //           padding: const EdgeInsets.all(8.0),
                      //           child: Column(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: <Widget>[
                      //               Padding(
                      //                 padding: const EdgeInsets.all(4.0),
                      //                 child: Image.asset(
                      //                     'assets/icons/address_work.png',
                      //                     color: Colors.white,
                      //                     height: 20),
                      //               ),
                      //               Text(
                      //                 'Workplace',
                      //                 style: TextStyle(
                      //                   fontSize: 8,
                      //                   color: Colors.white,
                      //                 ),
                      //                 textAlign: TextAlign.center,
                      //               )
                      //             ],
                      //           ),
                      //         ))) // Address 2
                    ],
                  ),
                  AddAddressForm(),
                  Center(child: ActionButton(
                      buttonText: 'Next',
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => SelectShippingMethodPage()));
                      }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
