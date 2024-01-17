import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/api_response.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../settings.dart';

class UserAPIs {
  static Future<User?> getUser(String id) async {
    print('fetching user........');
    try {
      final Uri url = Uri.parse(Variables.base_url + '/customers/${id}');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        User user = User.fromJson(data);

        final storage = FlutterSecureStorage();
        await storage.write(key: 'user', value: response.body);
        await storage.write(key: "last_logged_in_user", value: user.first_name);

        return user;
      } else {
        print('Failed to fetch user info: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return null;
    }
  }

  static Future<APIResponse> getCurrentlyLoggedInUser() async {
    print('fetching user........');
    APIResponse api_response = APIResponse();
    try {
      final storage = FlutterSecureStorage();
      final userStr = await storage.read(key: 'user');
      User user = User.fromJson(json.decode(userStr!));

      // final Uri url = Uri.parse(Variables.base_url + '/customers/${user.id}');

      // final response = await http.get(
      //   url,
      //   headers: {
      //     "Content-Type": "application/json",
      //     "Authorization": "Basic " + Settings.TOKEN
      //   },
      // );

      // if (response.statusCode == 200) {
      //   dynamic data = json.decode(response.body);
      //   User user = User.fromJson(data);

      //   //save the user in the storage
      //   await storage.write(key: "user", value: response.body);
        api_response.status = true;
        api_response.result = user;
        return api_response;
      // } else {
      //   print('Failed to fetch user info: ${response.statusCode}');
      //   api_response.status = false;
      //   api_response.error_message =
      //       'Failed to fetch user info: ${response.statusCode}';
      //   return api_response;
      // }
    } catch (e) {
      print('Error fetching user: $e');
      api_response.status = false;
      api_response.error_message = 'Error fetching user: $e';
      return api_response;
    }
  }

  static Future<bool> updateCustomer(User user) async {
    print('updating user');
    try {
      final Uri url = Uri.parse(Variables.base_url + '/customers/${user.id}');

      final response = await http.put(
        url,
        body: json.encode(user.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.WRITE_TOKEN
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        User user = User.fromJson(data);

        //save the user in the storage
        final storage = FlutterSecureStorage();
        await storage.write(key: "user", value: response.body);

        return true;
      } else {
        print('Failed to fetch user info: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Error fetching user: $e');
      return false;
    }
  }

  static Future<APIResponse> createCustomer(User user) async {
    print('updating user');
    try {
      final Uri url = Uri.parse(Variables.base_url + '/customers');
      //final data = user.toJson().toString();
      final response = await http.post(
        url,
        body: json.encode(user.toJson()),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.WRITE_TOKEN
        },
      );

      if (response.statusCode == 201) {
        dynamic data = json.decode(response.body);
        User user = User.fromJson(data);

        //save the user in the storage
        final storage = FlutterSecureStorage();
        await storage.write(key: "user", value: response.body);

        APIResponse apiResponse = APIResponse();
        apiResponse.result = user;
        apiResponse.status = true;
        return apiResponse;
      } else {
        print('Failed to fetch user info: ${response.statusCode}');
         APIResponse apiResponse = APIResponse();
        apiResponse.error_message = 'Error : ${json.decode(response.body)["message"]}';
        apiResponse.error_code = json.decode(response.body)["code"];
        apiResponse.status = false;
        return apiResponse;
      }
    } catch (e) {
      print('Error fetching user: $e');
      APIResponse apiResponse = APIResponse();
      apiResponse.error_message = 'Error fetching user: $e';
        apiResponse.status = false;
        return apiResponse;
    }
  }
}
