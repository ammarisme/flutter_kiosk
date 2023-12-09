import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/product.dart';
import '../models/user.dart';

class Variables {
  static String base_url = 'https://catlitter.lk/wp-json/wc/v3';
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
              "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy"
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
