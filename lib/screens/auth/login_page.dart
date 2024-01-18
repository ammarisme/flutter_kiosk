import 'package:ecommerce_int2/api_services/authentication_apis.dart';
import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/screens/auth/register_page.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  TextEditingController username = TextEditingController(text: '');
  TextEditingController password =
      TextEditingController(text: ''); //Eha&uDuy*4hoTTCXYwMCfDF(

  @override
  Widget build(BuildContext context) {

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Text(
          'Login with your mobile number/password.', //TODO: change to mobile number
          style: TextStyle(
            color: CONTENT_TEXT_COLOR_1,
            fontSize: 16.0,
          ),
        ));

    Widget loginButton = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () {
          //TODO: login
          String username = Utils.cleanMobileNumber(this.username.text);
          UserNotifier userNotifier =
              Provider.of<UserNotifier>(context, listen: false);
          userNotifier.login(username, this.password.text).then((response) {
            if (response.status == true) {
              CartAPIs.getCartNonce(username, this.password.text).then((value) {
                final storage = FlutterSecureStorage();
                storage.write(key: "nonce", value: value);
              });
              Utils.showToast("Welcome!", ToastType.done_success);
               Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            MainPage()));
            } else {
              Utils.showToast(
                  "Login failed : " + (response.error_message as String),
                  ToastType.done_error);
              print(response.status);
            }
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width / MAIN_BUTTON_FACTOR,
          height: MediaQuery.of(context).size.width / MAIN_BUTTON_HEIGHT_FACTOR,
          child: Center(
              child: new Text("Log In",
                  style: const TextStyle(
                      color: const Color(0xfffefefe),
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0))),
          decoration: BoxDecoration(
              color: BUTTON_COLOR_1,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.16),
                  offset: Offset(0, 5),
                  blurRadius: 10.0,
                )
              ],
              borderRadius: BorderRadius.circular(9.0)),
        ),
      ),
    );

    Widget loginForm = Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only( bottom: 4.0),
                  child: Row(children: [
                    Expanded(
                        child:
                        Container(
        padding: EdgeInsets.only(right: 16, left: 16.0, top: 4.0, bottom: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: TEXT_BOX_COLOR,
        ),
        child:
                         TextField(
                            controller: username,
                            style: TextStyle(fontSize: 16.0),
                            decoration: InputDecoration(
                              filled: true,
                              border: InputBorder.none,
                              fillColor: TEXT_BOX_COLOR, 
                              hintText: 'Mobile number',
                              prefixIcon:
                                  Icon(Icons.person), // Icon before the input
                            )))
                    )
                  ]),
                ),
                Row(children: [
                  Expanded(
                      child: PasswordTextField(
                    passwordController: password,
                    placeholder_text: "Password",
                  ))
                ]),
                loginButton
              ],
            ),
          );      

    Widget forgotPassword = Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Forgot your password? ',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Color.fromRGBO(255, 255, 255, 0.5),
              fontSize: 14.0,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'Reset password',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );

    Widget txtRegister = Row(children: [
      Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            'Don\'t have an account.?', //TODO: change to mobile number
            style: TextStyle(
              color: CONTENT_TEXT_COLOR_1,
              fontSize: 16.0,
            ),
          )),
      GestureDetector(
          onTap: (() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => RegisterPage()));
          }),
          child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                'Register Now.', //TODO: change to mobile number
                style: TextStyle(
                    color: LINK_TEXT_COLOR_1,
                    fontSize: 16.0,
                    backgroundColor: Colors.grey.shade100,
                    fontWeight: FontWeight.bold),
              ))),
    ]);

     Widget txtForgotPassword = Row(children: [
      Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Text(
            'Forgot your password.?', //TODO: change to mobile number
            style: TextStyle(
              color: CONTENT_TEXT_COLOR_1,
              fontSize: 16.0,
            ),
          )),
      GestureDetector(
          onTap: (() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => RegisterPage()));
          }),
          child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                'Reset Password.', //TODO: change to mobile number
                style: TextStyle(
                    color: LINK_TEXT_COLOR_1,
                    fontSize: 16.0,
                    backgroundColor: Colors.grey.shade100,
                    fontWeight: FontWeight.bold),
              ))),
    ]);


    return Scaffold(
      backgroundColor: PAGE_BACKGROUND_COLOR,
      body: Stack(
        children: <Widget>[
          // Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: AssetImage('assets/background.jpg'),
          //           fit: BoxFit.cover)),
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: PAGE_BACKGROUND_COLOR,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right:30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 2),
                WelcomeBack(),
                                Spacer(flex: 1),
                loginForm,
                Spacer(flex: 1),
                txtRegister,
                                Spacer(flex: 2),

                // Spacer(flex: 2),
                // forgotPassword,
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  TextEditingController passwordController;
  final String placeholder_text;
  PasswordTextField(
      {required this.passwordController, required this.placeholder_text});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 16, left: 16.0, top: 4.0, bottom: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: TEXT_BOX_COLOR,
        ),
        child: TextField(
          controller: widget.passwordController,
          style: TextStyle(fontSize: 16.0),
          obscureText: !isPasswordVisible,
          
          decoration: InputDecoration(
              border: InputBorder.none, // Remove the underline
            hintText: widget.placeholder_text,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),

            prefixIcon: Icon(Icons.security_rounded), // Icon before the input
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              child: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ),
        ));
  }
}

class WelcomeBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

    return Container(
      child: FutureBuilder<String>(
        future: userNotifier.getLastLoggedInUser(),
        builder: (context, snapshot) {
          if (snapshot.data != "") {
            return Text(
              'Welcome Back ${snapshot.data},',
              style: TextStyle(
                  color: CONTENT_TEXT_COLOR_1,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 5),
                      blurRadius: 10.0,
                    )
                  ]),
            );
          } else {
            // After reading from storage, use the data to build your widget
            return Text(
              'Welcome',
              style: TextStyle(
                  color: CONTENT_TEXT_COLOR_1,
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      offset: Offset(0, 5),
                      blurRadius: 10.0,
                    )
                  ]),
            );
          }
        },
      ),
    );
  }
}
