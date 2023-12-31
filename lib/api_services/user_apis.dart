import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:http/http.dart' as http;

import '../settings.dart';

class UserAPIs{

  static Future<User?> getUser(dynamic userId) async {
    print('fetching user........');
    try {
      final Uri url = Uri.parse(Variables.base_url + '/customers/$userId');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Basic "+Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        print(data);
        User user =  User.fromJson(data);
        return user;
      } else {
        print('Failed to cart info: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching products: $e');
      return null;
    }
  }

}
