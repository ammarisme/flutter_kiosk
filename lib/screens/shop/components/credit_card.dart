import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  String payment_method = "card";
  String payment_method_title = "Credit/Debit Card";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 250,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.deepPurple[700],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            'CREDIT CARD',
            style: TextStyle(color: Colors.white),
          ),
          Container(
            height: 25,
            width: 40,
            color: Colors.white,
          ),
          Text(
            'xxxx - xxxx - xxxx - 4951',
            style: TextStyle(color: Colors.white),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Name',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                'NASEEF NISAR',
                style: TextStyle(color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Cash extends StatelessWidget {
  String payment_method = "cash";
  String payment_method_title = "Cash";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 250,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.green.shade300,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.payments,
            size: 36, // Adjust the size of the icon
            color: Colors.white,
          ),
          SizedBox(height: 12), // Space between icon and text
          Text(
            'Cash',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14, // Adjust text size
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
        ],
      ),
    );
  }
}
