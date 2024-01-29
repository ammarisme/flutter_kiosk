// Define a ProductNotifier class that extends ChangeNotifier

import 'dart:convert';

import 'package:ecommerce_int2/api_services/authentication_apis.dart';
import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';

class UserNotifier extends ChangeNotifier {
  late User logged_in_user;
  late bool logged_in = false;

  Future<AuthenticationResponse> login(String email, String password) async {
    final authentication_response = await AuthenticationAPIs.getToken(email, password);
    if (authentication_response.status == true) {
      this.logged_in = true;
      //fetch user info
      logged_in_user = (await UserAPIs.getUser(authentication_response.token!["id"]))!;
      notifyListeners();
      return authentication_response;
    }else{
      //display an error popup
      return authentication_response;
    }
  }

  Future<void> get_user_info() async {
    notifyListeners();
  }

  Future<void> change_password() async {
    notifyListeners();
  }

  Future<void> send_otp() async {
    notifyListeners();
  }

  Future<void> verify_otp() async {
    notifyListeners();
  }

  Future<void> reset_password() async {
    //password change when its forgot
    notifyListeners();
  }

  Future<void> logout() async {
    final storage = FlutterSecureStorage();
    await storage.delete(key: 'jwt');
    await storage.delete(key: 'cart_nonce');
    await storage.delete(key: 'auth_header');
    await storage.delete(key: 'user').then((value) {
      this.logged_in = false;
    });

    notifyListeners();
  }

  Future<bool> checkIfLogged()  async {
        final storage = FlutterSecureStorage();
        try{
        await storage.read(key: 'user').then((value) {
           if (value!=null){
                dynamic data = json.decode(value);
                this.logged_in = true;
                this.logged_in_user =   User.fromJson(data);
            }
        });
        return this.logged_in;
        }catch(ex){
          return false;
        }
  }

    Future<String> getLastLoggedInUser()  async {
            final storage = FlutterSecureStorage();
            try{
              String last_logged_in_user = "";
            await storage.read(key: 'last_logged_in_user').then((value) {
              if (value!=null){
                    last_logged_in_user = value;
                }
            });
            return last_logged_in_user;
            }catch(ex){
              return "";
            }
      }

  
}
