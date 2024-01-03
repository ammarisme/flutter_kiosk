import 'package:intl/intl.dart';

class Utils {
  static String thousandSeperate(String numberString){
  try{
  double number = double.parse(numberString);
  return NumberFormat('#,###').format(number);
  }catch(ex){
    print(ex.toString() + "unable to parse number : "+ numberString);
    return "";
  }
  }
}