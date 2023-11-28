import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: TextField(
          keyboardType: TextInputType.text,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'First line',
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              height: 1,
              fontSize: 12,
            ),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.all(5.0),

          )
      ),
    );
  }
}
