import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/api_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../settings.dart';

class CartAPIs {
  static final base_url = 'https://catlitter.lk/wp-json/wc/store';

  static Future<Cart?> getCart() async {
    try {
      final Uri url = Uri.parse(base_url + '/cart');
      final storage = FlutterSecureStorage();

      var value_ba = await storage.read(key: 'auth_header');
      if (value_ba == null) {
        //The user hasn't logged in. This is guest checkout mode.
        //Maintain the cart in the local storage.
        print("user not logged in");
        var value_cart = await storage.read(key: 'local_cart');
        if (value_cart != null) {
          var empty_cart_json = json.decode(
              '{"coupons":[],"shipping_rates":[],"shipping_address":{"first_name":"","last_name":"","company":"","address_1":"","address_2":"","city":"","state":"","postcode":"","country":"","phone":""},"billing_address":{"first_name":"","last_name":"","company":"","address_1":"","address_2":"","city":"","state":"","postcode":"","country":"","email":"","phone":""},"items":[],"items_count":0,"items_weight":0,"cross_sells":[],"needs_payment":false,"needs_shipping":false,"has_calculated_shipping":false,"fees":[],"totals":{"total_items":"0","total_items_tax":"0","total_fees":"0","total_fees_tax":"0","total_discount":"0","total_discount_tax":"0","total_shipping":null,"total_shipping_tax":null,"total_price":"0","total_tax":"0","tax_lines":[],"currency_code":"LKR","currency_symbol":"Rs. ","currency_minor_unit":2,"currency_decimal_separator":".","currency_thousand_separator":",","currency_prefix":"Rs. ","currency_suffix":""},"errors":[],"payment_requirements":["products"],"extensions":{}}');
          Cart cart = Cart.fromJson(empty_cart_json);
          return cart;
        } else {}
      } else {
        print("Loading the cart of logged in user");
        //The user has logged in. This is authorized checkout mode.
        String basicAuth = value_ba as String;
        // String cart_nonce = await storage.read(key: 'cart_nonce') as String;

        final response = await http.get(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": basicAuth
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
     
      final storage = FlutterSecureStorage();
       final String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
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
      var value_ba = await storage.read(key: 'auth_header');
      if (value_ba == null) {
        //The user hasn't logged in. This is guest checkout mode.
        //Maintain the cart in the local storage.
        print("user not logged in");
        var value_cart = await storage.read(key: 'local_cart');
        if (value_cart != null) {

        } else {

        }
      } else {
        print("user is logged in");
        String? nonce = await storage.read(key: 'cart_nonce');

        final Uri url = Uri.parse(base_url + '/cart/add-item');

        Map<String, dynamic> postData = {
          'id': product_id, //16652, // Replace with your actual ID
          'quantity': quantity //1, // Replace with your actual quantity
        };

        String encodedData = json.encode(postData);

        final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/json",
            "Authorization": value_ba,
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
    String? nonce = await storage.read(key: 'nonce');

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
        return true;
      } else {
        return false;
      }
    } catch (ex) {
      return false;
    }
  }

  static Future<bool> deleteCartItemByKey({required String key}) async {
    final storage = FlutterSecureStorage();

    String? basicAuth = await storage.read(key: 'auth_header');
    String? nonce = await storage.read(key: 'nonce');

    try {
      final Uri url = Uri.parse(
          'https://catlitter.lk/wp-json/wc/store' + '/cart/items/' + key);

      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth as String,
          'nonce': nonce as String, // Add your nonce here
        },
      );

      if (response.statusCode == 204) {
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
    String? userStr = await storage.read(key: 'nonce');
    return userStr;
  }

  static Future<APIResponse> clearTheCart() async {
    try {
      final storage = FlutterSecureStorage();

      var value_ba = await storage.read(key: 'auth_header');
      if (value_ba == null) {
        //The user hasn't logged in. This is guest checkout mode.
        //Maintain the cart in the local storage.
        print("user not logged in");
        APIResponse apiResponse = APIResponse();
        apiResponse.error_message = 'Error : ${"Use not logged in."}';
        apiResponse.status = false;
        return apiResponse;
      } else {
        print("Loading the cart of logged in user");
        //The user has logged in. This is authorized checkout mode.
        String basicAuth = value_ba;
        String nonce = await storage.read(key: 'nonce') as String;
        // String cart_nonce = await storage.read(key: 'cart_nonce') as String;

        final response = await http.delete(
          Uri.parse(Variables.store_url +
              'cart/items'), // Replace with your authentication endpoint
          headers: {
            "Content-Type": "application/json",
            "Authorization": basicAuth,
            'nonce': nonce, // Add your nonce here
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
      }
    } catch (ex) {
      APIResponse apiResponse = APIResponse();
      apiResponse.error_message = 'Error : ${ex}';
      apiResponse.status = false;
      return apiResponse;
    }
  }
}
