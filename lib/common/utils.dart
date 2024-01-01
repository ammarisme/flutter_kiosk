import 'package:intl/intl.dart';

class Utils {
  static String thousandSeperate(String numberString){
  int number = int.parse(numberString);
  return NumberFormat('#,###').format(number);
  }
 
}