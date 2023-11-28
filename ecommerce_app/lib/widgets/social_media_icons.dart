import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialMediaIconsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            // Handle Facebook icon tap
            // Add your functionality here
          },
          child: Icon(
            Icons.facebook,
            size: 40,
            color: Colors.blue,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle Google icon tap or relevant action
            // Add your functionality here
          },
          child: ImageIcon(
              AssetImage('google_log.png'), // Replace with your Google logo asset path
              size: 40,
              color : Colors.red
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle Apple icon tap
            // Add your functionality here
          },
          child: Icon(
            Icons.apple,
            size: 40,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
