import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/api_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../settings.dart';

class CartAPIs {
  final base_url = 'https://catlitter.lk/wp-json/wc/store';

  Future<Cart?> getCart() async {
    try {
      final Uri url = Uri.parse(this.base_url + '/cart');
      final storage = FlutterSecureStorage();
      String? basicAuth = await storage.read(key: 'auth_header');

          
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth as String
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

  static Future<String?> getCartNonce(String username, String password) async {
    try {
      final Uri url = Uri.parse(Variables.store_url + 'cart');
      final String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      final storage = FlutterSecureStorage();
                storage.write(key: "auth_header", value: basicAuth);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth
        },
      );

      if (response.statusCode == 200) {
        return response.headers['nonce']!;
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

  Future<bool> addItem(product_id, quantity) async {
    try {

       final storage = FlutterSecureStorage();
      String? nonce =  await storage.read(key: 'nonce');
      String? basicAuth = await storage.read(key: 'auth_header');
          
      
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
          "Authorization":basicAuth as String,
          'nonce': nonce as String, // Add your nonce here
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

  static Future<bool> updateMyCartItemByKey({
    required String key,
    required int id,
    required int quantity,
  }) async {
    Map<String, dynamic> data = {
      'key': key,
      'id': id.toString(),
      'quantity': quantity.toString(),
    };
          final storage = FlutterSecureStorage();

  String? basicAuth = await storage.read(key: 'auth_header');
        String? nonce =  await storage.read(key: 'nonce');

          
    final encoded_body = jsonEncode(data);

    try {
      final Uri url = Uri.parse(
          'https://catlitter.lk/wp-json/wc/store' + '/cart/items/' + key);

      final response = await http.put(url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": basicAuth as String,
            'nonce': nonce as String, // Add your nonce here
          },
          body: encoded_body);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final jsonStr = json.decode(response.body);

        return true;
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  Future<bool> createOrder(Cart? cart) async {
    try {
      final Uri url =
          Uri.parse('https://catlitter.lk/wp-json/wc/v3' + '/orders');

      Map<String, dynamic>? postData = cart?.toJson();

      String encodedData = json.encode(postData);

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.WRITE_TOKEN,
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

  static Future<String?> getCartNonceFromStorage() async {
    final storage = FlutterSecureStorage();
    String? userStr =  await storage.read(key: 'nonce');
    return userStr;
  }

  static Future<APIResponse> clearTheCart() async {
    try {
      final storage = FlutterSecureStorage();
      String? nonce =  await storage.read(key: 'nonce');
      
      final response = await http.delete(
        Uri.parse(Variables.store_url +
            'cart/items'), // Replace with your authentication endpoint
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.WRITE_TOKEN,
          'nonce': nonce as String, // Add your nonce here
        },
      );

      if (response.statusCode == 200) {
        APIResponse payload = APIResponse();
        payload.status = true;

        // TODO: If you want to save the data in local storageSaving data
        // final storage = FlutterSecureStorage();
        // await storage.write(key: '//change this', value: response.body);

        return payload;
      } else {
        // Handle error cases here
        APIResponse apiResponse = APIResponse();
        apiResponse.error_message =
            'Error : ${json.decode(response.body)["message"]}';
        apiResponse.status = false;
        return apiResponse;
      }
    } catch (ex) {
      APIResponse apiResponse = APIResponse();
      apiResponse.error_message = 'Error : ${ex}';
      apiResponse.status = false;
      return apiResponse;
    }
  }
}
