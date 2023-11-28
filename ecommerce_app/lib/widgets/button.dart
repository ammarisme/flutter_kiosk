import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      child: MaterialButton(
        onPressed: () {
          // Add your onPressed function here
        },
        child: Text(
          'Button',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}