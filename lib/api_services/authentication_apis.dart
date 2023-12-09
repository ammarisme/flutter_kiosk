import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationAPIs{
  static Future<String?> getToken(String username, String password) async {
    final Map<String, String> data = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('https://catlitter.lk/?rest_route=/simple-jwt-login/v1/auth&username=catlitter.lk&password=Eha%26uDuy*4hoTTCXYwMCfDF('), // Replace with your authentication endpoint
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      String token = responseBody['data']["jwt"]; // Adjust based on your token structure
      return token;
    } else {
      // Handle error cases here
      print('Failed to obtain token: ${response.statusCode}');
      return null;
    }
  }
}
