
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 103,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your text...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person), // Add your icon here
            ),
          ),
        ],
      ),
    );
  }
}
