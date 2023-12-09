// Define a ProductNotifier class that extends ChangeNotifier
import 'package:ecommerce_int2/api_services/authentication_apis.dart';
import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:flutter/cupertino.dart';
import '../api_services/api_service.dart';
import '../models/user.dart';


class UserNotifier extends ChangeNotifier {
  late final User logged_in_user;
  late bool logged_in = false;

  Future<String?> login(String username, String password) async {
    final token = await AuthenticationAPIs.getToken(username, password);
    if (token != null){
      print("login");
      this.logged_in = true;
      //fetch user info
      logged_in_user = (await UserAPIs.getUser(1))!;
      print(logged_in_user.first_name);
      // logged_in_user = User(
      //     {required this.gender,
      //       required this.name,
      //       required this.location,
      //       required this.email,
      //       required this.login,
      //       required this.dob,
      //       required this.registered,
      //       required this.phone,
      //       required this.cell,
      //       required this.id,
      //       required this.picture,
      //       required this.nat});
      notifyListeners();
    }
  }


  Future<void> get_user_info() async {
    ApiService apiService = ApiService();
    https://catlitter.lk/wp-json/wc/v3/customers/1
    notifyListeners();
  }

  Future<void>  change_password() async {
    ApiService apiService = ApiService();
    notifyListeners();
  }

  Future<void>  send_otp() async {
    ApiService apiService = ApiService();
    notifyListeners();
  }

  Future<void>  verify_otp() async {
    ApiService apiService = ApiService();
    notifyListeners();
  }

  Future<void>  reset_password() async { //password change when its forgot
    ApiService apiService = ApiService();
    notifyListeners();
  }

  Future<void> logout(dynamic categoryId) async{
    // _products_of_category = await ApiService.getProducts(categoryId);
    // this.selectedCategoryId = categoryId;
    notifyListeners();
  }
}
