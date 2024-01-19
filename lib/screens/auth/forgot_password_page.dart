import 'dart:math';

import 'package:ecommerce_int2/api_services/sms_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:ecommerce_int2/screens/settings/change_password_page.dart';
import 'package:flutter/material.dart';

import 'confirm_otp1_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneNumber = TextEditingController(text: '46834683');

  GlobalKey prefixKey = GlobalKey();
  double prefixWidth = 0;

  @override
  Widget build(BuildContext context) {
    Widget background = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/background.jpg'), fit: BoxFit.cover),
      ),
      foregroundDecoration: BoxDecoration(color: THEME_COLOR_3),
    );

    Widget title = Text(
      'Forgot your Password?',
      style: TextStyle(
          color:TEXT_COLOR_1,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
        ),
    );

    Widget subTitle = Padding(
        padding: const EdgeInsets.only(right: 56.0),
        child: Text(
          'Enter your registered mobile number to get the OTP',
          style: TextStyle(
            color: TEXT_COLOR_1,
            fontSize: 16.0,
          ),
        ));


    Widget phoneForm = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         CustomTextField(placeholder_text: 'Your registered mobile number',
                  onChange: (value) => {},
                  icon: Icon(Icons.phone), defaultValue: "", fieldType: TextFieldType.text, textEditingController: phoneNumber),
           ActionButton(buttonText: "Send OTP", onTap: (){

             String mobileNumber = Utils.cleanMobileNumber(this.phoneNumber.text) ;
                          //Send SMS.
                          Random random = Random();
                          int randomNumber = random.nextInt(9000) + 1000;

                          SMSAPIs.sendSMS(mobileNumber,
                                  "Your OTP is " + randomNumber.toString())
                              .then((value) {
                            if (value.status == true) {
                              Utils.showToast(
                                  "OTP sent to ${mobileNumber}. Please check your SMS inbox.",
                                  ToastType.done_success);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ConfirmOtp1Page(
                                        phoneNumber: mobileNumber,
                                        otp: randomNumber,
                                        postConfirmation: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => ChangePasswordPage()
                                            ));
                                        },
                                      )));
                            } else {}
                          });

           }, buttonType: ButtonType.enabled_default),
        ],
      );

    // TODO: Widget resendAgainText = Padding(
    //     padding: const EdgeInsets.only(bottom: 20),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         //TODO:  Text(
    //         //   "Didn't receive the OPT? ",
    //         //   style: TextStyle(
    //         //     fontStyle: FontStyle.italic,
    //         //     color: TEXT_COLOR_1,
    //         //     fontSize: 14.0,
    //         //   ),
    //         // ),
    //         InkWell(
    //           onTap: () {},
    //           child: Text(
    //             'Resend again',
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontWeight: FontWeight.bold,
    //               fontSize: 14.0,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ));
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Container(
          child: Scaffold(
            backgroundColor: PAGE_BACKGROUND_COLOR,
            appBar: AppBar(
              backgroundColor: PAGE_BACKGROUND_COLOR,
              elevation: 0.0,
            ),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Spacer(flex: 3),
                      title,
                      Spacer(),
                      subTitle,
                      Spacer(flex: 2),
                      phoneForm,
                      Spacer(flex: 2),
                      // resendAgainText
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}
