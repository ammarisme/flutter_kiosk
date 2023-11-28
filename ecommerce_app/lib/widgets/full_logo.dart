// Create a custom widget to display the image loaded from assets
import 'package:flutter/cupertino.dart';

class FullLogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 203,
      height: 103,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('catlitter_logo.jpeg'), // Replace with your image path
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
