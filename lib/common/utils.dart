import 'package:intl/intl.dart';

class Utils {
  static String thousandSeperate(String numberString){
  try{
int number = int.parse(numberString);
  return NumberFormat('#,###').format(number);
  }catch(ex){
    print(ex);
    return "";
  }
  
  }
 
}