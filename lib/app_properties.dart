import 'package:flutter/material.dart';

const Color PAGE_BACKGROUND_COLOR =Color.fromRGBO(230, 230, 230, 1);
const Color PAGE_BACKGROUND_COLOR_2 =Color.fromRGBO(255, 255, 255, 1);
const Color TEXT_BOX_COLOR = Color.fromARGB(255, 255, 255, 255);
const Color THEME_COLOR_1 = Color.fromARGB(150, 0, 0, 0);
const Color THEME_COLOR_2 = Color.fromARGB(150, 0, 0, 0);
const Color THEME_COLOR_3 = Color.fromRGBO(0, 0, 0, 0.694);
const Color darkGrey = Color(0xff202020);
const Color CONTENT_TEXT_COLOR_1 = Color.fromRGBO(0, 0, 0, 0.588);
const Color LINK_TEXT_COLOR_1 = Color.fromARGB( 131, 0, 0, 131);
const Color LINK_TEXT_COLOR_2 = Color.fromARGB(167, 0, 0, 92);




const Color PRICE_COLOR_SALE = Colors.orange;

//Button colors
const Color BUTTON_COLOR_1 = Color.fromARGB(238, 22, 10, 0);
const Color BUTTON_COLOR_1_INACTIVE = Color.fromARGB(171, 133, 133, 133);
const Color BUTTON_TEXT_COLOR1 = Color.fromARGB(255, 255, 255, 255);
const MAIN_BUTTON_FACTOR = 4;
const MAIN_BUTTON_HEIGHT_FACTOR = 10;
const double BUTTON_FONT_SIZE = 10;
const double SMALL_BUTTON_FONT_SIZE = 8;


//Button colors
const Color TEXT_COLOR_1 = Color(0xff202020);
const double BUTTON_ICON_SIZE = 18;



const LinearGradient MAIN_BUTTON_GRADIENTS = LinearGradient(colors: [
  BUTTON_COLOR_1,
  BUTTON_COLOR_1,
  BUTTON_COLOR_1,
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);


const LinearGradient DISABLED_BUTTON_GRADIENTS = LinearGradient(colors: [
   Color.fromARGB(239, 167, 167, 167),
   Color.fromARGB(239, 167, 167, 167),
   Color.fromARGB(239, 167, 167, 167),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);


const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 160;
  return size * MediaQuery.of(context).size.height / baseHeight;
}

screenAwareWidth(int width, BuildContext context) {

  double baseWidth = 75;
  return width * MediaQuery.of(context).size.width / baseWidth;
}