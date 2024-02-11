import 'package:fluter_kiosk/app_properties.dart';
import 'package:fluter_kiosk/screens/auth/login_page.dart';
import 'package:fluter_kiosk/screens/components/ui_components.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController password1 = TextEditingController();
    TextEditingController password2 = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        //brightness: Brightness.light,
        backgroundColor: Colors.transparent,
        title: Text(
          'Settings',
          style: TextStyle(color: darkGrey),
        ),
        elevation: 0,
      ),
      body: Column(
          children:[ 
              PasswordTextField(passwordController: password1, placeholder_text: "New password"),
                            PasswordTextField(passwordController: password2, placeholder_text: "Repeat the same password"),
           ActionButton(buttonText: "Confirm", onTap: (){
           }, buttonType: ButtonType.enabled_default),
          ]
    ));
  }
}
