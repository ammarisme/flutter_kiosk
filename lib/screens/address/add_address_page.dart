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
