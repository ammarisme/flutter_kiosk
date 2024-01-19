import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthenticationResponse {
  bool status = false;
  String? error_message;
  Map<String, dynamic>? token;
}

class AuthenticationAPIs {
  static Future<AuthenticationResponse> getToken(
      String username, String password) async {
    AuthenticationResponse payload = AuthenticationResponse();
    final Map<String, String> data = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(
          'https://catlitter.lk/?rest_route=/simple-jwt-login/v1/auth&username=${username}&password=${password}'), // Replace with your authentication endpoint
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      String token =
          responseBody['data']["jwt"]; // Adjust based on your token structure
      payload.token = Jwt.parseJwt(token);
      payload.status = true;

      // Saving data
      final storage = FlutterSecureStorage();
      await storage.write(key: 'jwt', value: token);

      return payload;
    } else {
      // Handle error cases here
      payload.status = false;
      payload.error_message = "Invalid credentials";
      print('Failed to obtain token: ${response.statusCode}');

      return payload;
    }
  }

  static Future<bool> logout(String token) async {
    final Map<String, String> data = {
      'JWT': token,
    };

    final response = await http.post(
      Uri.parse(
          'https://catlitter.lk/?rest_route=/simple-jwt-login/v1/auth/revoke'), // Replace with your authentication endpoint
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(json.encode(data));
    if (response.statusCode == 200) {
      final storage = FlutterSecureStorage();
      await storage.delete(key: 'jwt');
      return true;
    } else {
      // Handle error cases here
      print('Failed to obtain token: ${response.statusCode}');
      return false;
    }
  }
}


