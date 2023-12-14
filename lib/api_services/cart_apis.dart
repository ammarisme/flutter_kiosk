import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';

class CartAPIs {
  final base_url = 'https://catlitter.lk/wp-json/wc/store';

  Future<Cart?> getCart() async {
    print('fetching cart........');
    try {
      final Uri url = Uri.parse(this.base_url + '/cart');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy"
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Cart cart = Cart.fromJson(data);
        cart.nonce = response.headers['nonce']!;
        return cart;
      } else {
        print('Failed to load cart info: ${response.statusCode}');
        return null;
      }
    } catch (e, stackTrace) {
      print('Error fetching cart: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }

  Future<bool> addItem(product_id, quantity, nonce) async {
    try {
      final Uri url = Uri.parse(this.base_url + '/cart/add-item');

      Map<String, dynamic> postData = {
        'id': product_id, //16652, // Replace with your actual ID
        'quantity': quantity //1, // Replace with your actual quantity
      };

      String encodedData = json.encode(postData);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy",
          'nonce': nonce, // Add your nonce here
        },
        body: encodedData,
      );

      if (response.statusCode == 201) {
        print('Product added to cart');
        return true;
      } else {
        print('Failed to cart info: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      print('Error fetching cart: $e');
      print('Stack trace: $stackTrace');
    }
    return false;
  }

  Future<bool> createOrder(Cart? cart) async {
    try {
      final Uri url = Uri.parse( 'https://catlitter.lk/wp-json/wc/v3'+ '/orders');

      Map<String, dynamic>? postData = cart?.toJson();

      String encodedData = json.encode(postData);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy",
          'nonce': cart!.nonce, // Add your nonce here
        },
        body: encodedData,
      );

      if (response.statusCode == 201) {
        print('Order created');
        return true;
      } else {
        print('Error in order creation: ${response.statusCode}');
        print(encodedData);
        print(response.body);
      }
    } catch (e, stackTrace) {
      print('Error order creation cart: $e');
      print('Stack trace: $stackTrace');
    }
    return false;
  }
}
