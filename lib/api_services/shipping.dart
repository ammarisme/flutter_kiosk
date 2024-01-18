import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class Shipping {
  late Map<String, dynamic> shipping_data;

     Future<Map<String, dynamic>?> loadJson() async {
    // String jsonString = await rootBundle.loadString('cities-by-district.json');
    // districtCityMap = json.decode(jsonString);
    try {
      String jsonString = await rootBundle.loadString('assets/shipping-data.json');
      this.shipping_data = json.decode(jsonString);
      return shipping_data;
    } catch (e) {
      print('Error loading JSON: $e');
      return null;
    }

  }
 
   double getShippingCost(String city, String district, double weight){
    if(district == "Colombo"){
      //km based cost
       dynamic myCity = shipping_data[district]["cities"].firstWhere((city_el) => city_el["location"] == city);
       double cost = myCity["flat_rate"];
       return cost;
    }else{
      //weight based cost
      double cost = 300;//myCity["flat_rate"];
      if(weight > 1){
        cost = cost+ (weight-1) * 60;
      }
      return cost;
    }
  }
}