import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../settings.dart';

class CartAPIs {
  final base_url = 'https://catlitter.lk/wp-json/wc/store';

  Future<Cart?> getCart() async {
        try {
      final Uri url = Uri.parse(this.base_url + '/cart');
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic "+Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Cart cart = Cart.fromJson(data);
        cart.nonce = response.headers['nonce']!;
        
        final storage = FlutterSecureStorage();
        await storage.write(key: 'cart_nonce', value: cart.nonce);
        
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
              "Basic "+Settings.WRITE_TOKEN,
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

  static Future<bool> updateMyCartItemByKey(
      {required String key,
      required int id,
      required int quantity,
      required String nonce,
      }) async {
  Map<String, dynamic> data = {
      'key': key,
      'id': id.toString(),
      'quantity': quantity.toString(),

    };
    
    final encoded_body = jsonEncode(data);

       try {

    final Uri url = Uri.parse( 'https://catlitter.lk/wp-json/wc/store'+ '/cart/items/'+ key);

    final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic "+Settings.WRITE_TOKEN,
          'nonce': nonce, // Add your nonce here
        },
        body: encoded_body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final jsonStr = json.decode(response.body);

      return true;
    } else {
      return false;
    }
       } catch (ex){
        return false;
       }
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
          "Basic "+Settings.TOKEN,
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
