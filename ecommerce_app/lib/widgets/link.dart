import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinkWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Navigates back to the previous page (main page)
      },
      child: Text(
        'Link',
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue,
          decoration: TextDecoration.none, // Removes the underline
        ),
      ),
    );
  }
}
