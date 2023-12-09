import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:http/http.dart' as http;

class UserAPIs{

  static Future<User?> getUser(dynamic userId) async {
    print('fetching user........');
    try {
      final Uri url = Uri.parse(Variables.base_url + '/customers/$userId');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization" : "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy"
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        print(data);
        User user =  User.fromJson(data);
        return user;
      } else {
        print('Failed to load user info: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching products: $e');
      return null;
    }
  }

}
