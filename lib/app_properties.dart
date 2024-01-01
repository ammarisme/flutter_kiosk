import 'package:flutter/material.dart';

const Color PAGE_BACKGROUND_COLOR = Color.fromARGB(255, 255, 255, 255);
const Color mediumYellow = Color(0xffFDB846);
const Color darkYellow = Color(0xffE99E22);
const Color transparentYellow = Color.fromRGBO(253, 184, 70, 0.7);
const Color darkGrey = Color(0xff202020);

//Button colors
const Color BUTTON_COLOR_1 = Color(0xff202020);
const Color BUTTON_COLOR_1_INACTIVE = Color.fromARGB(255, 107, 106, 106);
const Color BUTTON_TEXT_COLOR1 = Color.fromARGB(255, 255, 255, 255);
const MAIN_BUTTON_FACTOR = 4;
const double BUTTON_FONT_SIZE = 12;

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