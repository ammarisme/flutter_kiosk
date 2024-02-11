import 'dart:convert';
import 'package:fluter_kiosk/api_services/api_service.dart';
import 'package:fluter_kiosk/models/api_response.dart';
import 'package:fluter_kiosk/models/order.dart';
import 'package:fluter_kiosk/settings.dart';
import 'package:http/http.dart' as http;

class OrderAPIs {
  static Future<APIResponse> getCustomerOrders(String customerId) async {
    try {
      final response = await http.get(
        Uri.parse(Variables.base_url +
            '/orders?customer=${customerId}'), // Replace with your authentication endpoint
        headers: {
          'Content-Type': 'application/json',
          "Authorization": "Basic " + Settings.TOKEN,
        },
      );

      if (response.statusCode == 200) {
        APIResponse payload = APIResponse();
        List<dynamic> responseBody = json.decode(response.body);
        List<Order> orders = [];
        responseBody.forEach((item) {
          final Order order = Order.fromJson(item);
          orders.add(order);
        });
        payload.result = orders;
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
      apiResponse.error_message = 'Error : ${ex}';
      apiResponse.status = false;
      return apiResponse;
    }
  }
}
