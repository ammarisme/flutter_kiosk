import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/data/data.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../change_notifiers/cart_notifiers.dart';

class AddAddressForm extends StatefulWidget {
  AddAddressForm();

  @override
  _AddAddressForm createState() => _AddAddressForm();
}

class _AddAddressForm extends State<AddAddressForm> {
 

  User? user;

  @override
  void initState() {
    super.initState();
    UserAPIs.getCurrentlyLoggedInUser().then((value) {
      setState(() {
        user = value;
      });
    });

    // Make API call here
  }

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);

    return user == null
        ? Container()
        : SizedBox(
            height: screenAwareSize(100, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextField(
                  placeholder_text: 'First name (eg:- Jhon)',
                  onChange: (value) =>
                      {cartNotifier.addOrUpdateFirstName(value)},
                  icon: Icon(Icons.person),
                  defaultValue: user!.first_name,
                ),
                CustomTextField(
                  placeholder_text: 'Last name (eg:- Prince Street',
                  onChange: (value) =>
                      {cartNotifier.addOrUpdateLastName(value)},
                  icon: Icon(Icons.person),
                  defaultValue: user!.last_name,
                ),
                CustomTextField(
                  placeholder_text: 'House/Flat Number (eg:- 34/2 A)',
                  onChange: (value) =>
                      {cartNotifier.addOrUpdateAddress1(value)},
                  icon: Icon(Icons.house),
                  defaultValue: user!.billing_info.address_1,
                ),
                CustomTextField(
                    placeholder_text: 'Street name (eg:- Prince Street',
                    onChange: (value) =>
                        {cartNotifier.addOrUpdateAddress2(value)},
                    icon: Icon(Icons.add_road),
                    defaultValue: user!.billing_info.address_2),
                    // SearchableDropDown(
                    //   label: "",
                    //   hint: "",
                    //   selectableItems: Data.cities,
                    // ),
                CustomDropDownField(
                    input_list: Data.cities,
                    placeholder_text: 'Select City',
                    onChange: (value) => {cartNotifier.addOrUpdateCity(value!)},
                    defaultValue: "",
                    icon: Icon(Icons.place)),
                CustomDropDownField(
                    input_list: Data.provinces,
                    placeholder_text: 'Select Province',
                    onChange: (value) =>
                        {cartNotifier.addOrUpdateStateOrProvince(value!)},
                    defaultValue: "",
                    icon: Icon(Icons.location_city)),
                //Street name
                Row(
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      onChanged: (value) {
                        if (value == true) {
                          cartNotifier.copyShippingInfoToBilling();
                        } else {}
                      },
                    ),
                    Text('Use the same as the Billing address.')
                  ],
                )
              ],
            ),
          );
  }
}
