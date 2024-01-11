import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/user.dart';
import '../settings.dart';

class Variables {
  static String base_url = 'https://catlitter.lk/wp-json/wc/v3';
  static String store_url = "https://catlitter.lk/wp-json/wc/store/v1/";
  static String notifylk_url = "https://app.notify.lk/api/v1";
  static String sms_sender_id = "CATLITTER";
  static String sms_api_key = 'b3V5qfsJJ4c4GnQJbGJq';
  static String sms_user_id = '12719' ;
}

//API service
class ApiService {
  static String base_url() {
    return 'https://catlitter.lk/wp-json/wc/v3';
  }

  static Future<List<Product>> getProducts(dynamic categoryId) async {
    print('fetching products........');
    try {
      final Uri url = Uri.parse(base_url() + '/products?category=$categoryId');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic "+ Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Product> products =
            data.map((item) => Product.fromJson(item)).toList();
        return products;
      } else {
        print('Failed to load products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<List<User>> getUsers({int nrUsers = 1}) async {
    try {
      final response = await http.get(
          //TODO flutter 2 migration
          Uri(
            path: base_url(),
          ),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        Map data = json.decode(response.body);
        Iterable list = data["results"];
        List<User> users = list.map((l) => User.fromJson(l)).toList();
        return users;
      } else {
        // print(response.body);
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
