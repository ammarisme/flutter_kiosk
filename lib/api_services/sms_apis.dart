import 'dart:convert';
import 'package:ecommerce_int2/api_services/api_service.dart';
import 'package:ecommerce_int2/models/api_response.dart';
import 'package:http/http.dart' as http;

class SMSAPIs {
  static Future<APIResponse> sendSMS(String phoneNumber, String message) async {
    try {
      final Map<String, String> data = {
        'to': phoneNumber,
        'message': message,
        'sender_id': Variables.sms_sender_id,
        'api_key': Variables.sms_api_key,
        'user_id': Variables.sms_user_id,
      };

      final response = await http.post(
        Uri.parse(Variables.notifylk_url +
            '/send'), // Replace with your authentication endpoint
        body: json.encode(data),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        APIResponse payload = APIResponse();
        Map<String, dynamic> responseBody = json.decode(response.body);
        payload.result = responseBody;
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
      print(ex);
        APIResponse apiResponse = APIResponse();
        apiResponse.error_message =
            'Error : ${ex}}';
        apiResponse.status = false;
        return apiResponse;    }
  }
}
