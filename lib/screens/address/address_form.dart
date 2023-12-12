import 'package:ecommerce_int2/app_properties.dart';
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
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'House/Flat Number (eg:- 34/2 A)'),
              onChanged: (value) => {
                cartNotifier.addOrUpdateAddress1(value)
              },
            ),
          ), //House/flat number
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: TextField(
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Street name (eg:- Prince Street'),
                onChanged: (value) => {
                  cartNotifier.addOrUpdateAddress2(value)
                }
            ),
          ), //Street name
          //Street name
          Container(
            padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.white,
            ),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Select area',
              ),
              items: areaList.map((String area) {
                return DropdownMenuItem<String>(
                  value: area,
                  child: Text(area),
                );
              }).toList(),
              onChanged: (value) => {
                cartNotifier.addOrUpdateAddress2(value!)
              },
              value: null, // Track the selected area
            ),
          ),
          Row(
            children: <Widget>[
              Checkbox(
                value: true,
                onChanged: (_) {},
              ),
              Text('Use the same as the Billing address.')
            ],
          )
        ],
      ),
    );
  }
}
