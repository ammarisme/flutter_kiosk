import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../change_notifiers/cart_notifiers.dart';


class AddAddressForm extends StatelessWidget {

  final List<String> areaList = [
    'Area A',
    'Area B',
    'Area C',
    'Area D',
  ];

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
    Provider.of<CartNotifier>(context, listen: false);

    return SizedBox(
      height: 400,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomTextField(placeholder_text: 'First name (eg:- Jhon)',
              onChange: (value) => {
                cartNotifier.addOrUpdateFirstName(value)
              }),
          CustomTextField(placeholder_text: 'Last name (eg:- Prince Street',
              onChange: (value) => {
                cartNotifier.addOrUpdateLastName(value)
              }),
          CustomTextField(placeholder_text: 'House/Flat Number (eg:- 34/2 A)',
              onChange: (value) => {
                cartNotifier.addOrUpdateAddress1(value)
              }),
          CustomTextField(placeholder_text: 'Street name (eg:- Prince Street',
              onChange: (value) => {
                cartNotifier.addOrUpdateAddress2(value)
              }),
          CustomDropDownField(input_list: areaList, placeholder_text: 'Select area', onChange: (value) => {
            cartNotifier.addOrUpdateCity(value!)
          }),
          CustomDropDownField(input_list: areaList, placeholder_text: 'Select State/Province', onChange: (value) => {
            cartNotifier.addOrUpdateStateOrProvince(value!)
          }),
          //Street name
          Row(
            children: <Widget>[
              Checkbox(
                value: true,
                onChanged: (value) {
                  if(value==true){
                    cartNotifier.copyShippingInfoToBilling();
                  }else{

                  }
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
