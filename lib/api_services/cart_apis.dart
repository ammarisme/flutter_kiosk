import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';

class CartAPIs{
  final base_url = 'https://catlitter.lk/wp-json/wc/store';

  Future<Cart?> getCart() async {
    print('fetching cart........');
    try {
      final Uri url = Uri.parse(this.base_url + '/cart');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy"
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Cart cart =  Cart.fromJson(data);
        cart.nonce = response.headers['nonce'];
        return cart;
      } else {
        print('Failed to load user info: ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching cart: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

}
