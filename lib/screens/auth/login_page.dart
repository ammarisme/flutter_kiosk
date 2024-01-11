import 'package:ecommerce_int2/api_services/authentication_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/screens/auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  TextEditingController username =
  TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: ''); //Eha&uDuy*4hoTTCXYwMCfDF(

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier =
          Provider.of<UserNotifier>(context, listen: false);
    userNotifier.checkIfLogged().then((logged_in) => {
        print("user is logged in : "+ logged_in.toString())
      });
 
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
          UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
          userNotifier.login(username,this.password.text).then((response)
          {if (response.status == true){
              Utils.showToast("Welcome!", ToastType.done_success);
            print(response.status);
          } else {
            Utils.showToast("Login failed : "+ (response.error_message as String), ToastType.done_error);
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
      height: 240,
      child: Stack(
        children: <Widget>[
          Container(
            height: 240,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            decoration: BoxDecoration(
                color: Color.fromRGBO(255, 255, 255, 0.8),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: 
                    Row(children: 
                    [
                      Expanded(child:TextField(
                    controller: username,
                    style: TextStyle(fontSize: 16.0),
                    decoration: InputDecoration(
                hintText: 'Username',
                prefixIcon: Icon(Icons.person), // Icon before the input
              )
                  ) )
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child:   Row(children: 
                    [
                      Expanded(child:TextField(
                    controller: password,
                    style: TextStyle(fontSize: 16.0),
                    obscureText: true,
                    decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: Icon(Icons.security_rounded), // Icon before the input
              )
                  ),
                )]))
              ,
              loginButton
              ],
            ),
          ),
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
          onTap: ((){
            Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        RegisterPage()));
          }),
          child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Text(
          'Register Now.', //TODO: change to mobile number
          style: TextStyle(
            color: LINK_TEXT_COLOR_1,
            fontSize: 16.0,
            backgroundColor: Colors.grey.shade100,
            fontWeight: FontWeight.bold
          ),
        ))
        ),
        
 ]);


    return Scaffold(

      body: Stack(
        children: <Widget>[

          Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: PAGE_BACKGROUND_COLOR,

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(flex: 3),
                WelcomeBack(),
                Spacer(flex:3),
                subTitle,
                Spacer(flex: 1),
                loginForm,
                Spacer(flex: 1),
                txtRegister,
                Spacer(flex: 2),
                forgotPassword,
              ],
            ),
          )
        ],
      ),
    );
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
            return    Text(
      'Welcome Back ${snapshot.data},',
      style: TextStyle(
          color:CONTENT_TEXT_COLOR_1,
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