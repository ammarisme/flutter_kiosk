import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

enum ToastType {
  in_progress,
  done_error,
  done_success,
}

class Utils {
  static String thousandSeperate(String numberString) {
    try {
      double number = double.parse(numberString);
      return NumberFormat('#,###').format(number);
    } catch (ex) {
      print(ex.toString() + "unable to parse number : " + numberString);
      return "";
    }
  }

  static String cleanMobileNumber(String mobileNumber){
    // Remove '+'
    mobileNumber = mobileNumber.replaceAll("+", "");
    
    // Replace leading '0'
    if (mobileNumber.startsWith("0")) {
        mobileNumber = mobileNumber.replaceFirst("0", "94");
    }
    
    return mobileNumber;
}

static String makeDateStringHumanReadable(dateString){
  DateTime dateTime = DateTime.parse(dateString);
  
  String formattedDate = DateFormat.yMMMMd().add_jm().format(dateTime);
  
  return formattedDate;
   // Output: February 8, 2024 6:10 PM
}

  static showToast(String msg, ToastType type) {
      // Fluttertoast.showToast(
    //   msg: msg,
    //   toastLength: Toast.LENGTH_SHORT, // Duration of the toast
    //   gravity: ToastGravity.BOTTOM, // Location of the toast
    //   backgroundColor: Colors.grey,
    //   textColor: type == ToastType.done_error ? Colors.red : Colors.white,
    // );
  }


  static saveSettings(settings) async{
 final storage = FlutterSecureStorage();
      await storage.write(key: "settings", value:settings);
  }

  static  Future<String?> getLocalSettings() async {
    final storage = FlutterSecureStorage();
    return storage.read(key: "settings");
    
  }
}
