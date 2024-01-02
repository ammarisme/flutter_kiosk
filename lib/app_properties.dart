import 'package:flutter/material.dart';

const Color PAGE_BACKGROUND_COLOR = Color.fromARGB(255, 255, 255, 255);
const Color THEME_COLOR_1 = Color.fromARGB(150, 0, 0, 0);
const Color THEME_COLOR_2 = Color.fromARGB(150, 0, 0, 0);
const Color THEME_COLOR_3 = Color.fromRGBO(0, 0, 0, 0.694);
const Color darkGrey = Color(0xff202020);

const Color PRICE_COLOR_SALE = Colors.orange;

//Button colors
const Color BUTTON_COLOR_1 = Color.fromARGB(240, 165, 0, 0);
const Color BUTTON_COLOR_1_INACTIVE = Color.fromARGB(120, 165, 0, 0);
const Color BUTTON_TEXT_COLOR1 = Color.fromARGB(255, 255, 255, 255);
const MAIN_BUTTON_FACTOR = 4;
const double BUTTON_FONT_SIZE = 10;


//Text colors
const Color TEXT_COLOR_1 = Color(0xff202020);
const double BUTTON_ICON_SIZE = 18;



const LinearGradient MAIN_BUTTON_GRADIENTS = LinearGradient(colors: [
  BUTTON_COLOR_1,
  BUTTON_COLOR_1,
  BUTTON_COLOR_1,
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);

const List<BoxShadow> shadow = [
  BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6)
];

screenAwareSize(int size, BuildContext context) {
  double baseHeight = 640.0;
  return size * MediaQuery.of(context).size.height / baseHeight;
}