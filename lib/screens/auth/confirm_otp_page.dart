import 'package:ecommerce_int2/api_services/authentication_apis.dart';
import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class ConfirmOtpPage extends StatefulWidget {
  final User user;
  final int otp;
  final Function postConfirmation;
  ConfirmOtpPage(
      {required this.user, required this.otp, required this.postConfirmation});
  @override
  _ConfirmOtpPageState createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtpPage> {
  bool verified = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.cover)),
        child: Container(
            decoration: BoxDecoration(color: THEME_COLOR_3),
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  title: Text(
                    'OTP verification',
                    style: const TextStyle(
                        color: darkGrey,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: 18.0),
                  ),
                ),
                body: Stack(children: <Widget>[
                  Column(children: [
                    // Image.network("Add Image Link"),
                    SizedBox(
                      height: screenAwareSize(10, context),
                    ),
                    Text(
                      "Enter verification code sent via SMS to " +
                          widget.user!.phone_number,
                    ),
                    SizedBox(
                      height: screenAwareSize(10, context),
                    ),

                    OTPTextField(
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        fieldWidth: 50,
                        style: TextStyle(fontSize: 17),
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        onCompleted: (pin) {
                          verified = (pin == widget.otp.toString());
                          if (verified) {
                            Utils.showToast(
                                "OTP verified! Please wait while we create an account for you...",
                                ToastType.done_success);
                            if (widget.user.id > 0) {
                               UserAPIs.updateCustomer(widget.user as User)
                                  .then((value) {
                                Utils.showToast("Updated customer info!",
                                    ToastType.done_success);
                                setState(() {
                                  widget.postConfirmation();
                                });
                              });
 
                            } else {
                              UserAPIs.createCustomer(widget.user as User)
                                  .then((value) {
                                if (value.status == true) {
                                  Utils.showToast(
                                      "We created an account for you!",
                                      ToastType.done_success);
                                  Utils.showToast("Logging you in..",
                                      ToastType.done_success);
                                  AuthenticationAPIs.getToken(
                                          widget.user.username,
                                          widget.user.password)
                                      .then((value) {
                                    Utils.showToast(
                                        "You've logged in as " +
                                            widget.user.first_name +
                                            " " +
                                            widget.user.last_name,
                                        ToastType.done_success);
                                  });
                                  setState(() {
                                    widget.user!.id = value.result.id;
                                    widget.postConfirmation();
                                  });
                                } else {
                                  Utils.showToast(
                                      (value.error_message as String),
                                      ToastType.done_error);
                                }
                              });
                                                        }
                          } else {
                            Utils.showToast("OTP verification failed",
                                ToastType.done_success);
                          }
                        },
                        otpFieldStyle: OtpFieldStyle(
                          borderColor: Colors.black,
                        )),
                    SizedBox(
                      height: screenAwareSize(10, context),
                    ),

                    //Add Button Widget Here
                    // ActionButton(
                    //     buttonType: verified
                    //         ? ButtonType.enabled_default
                    //         : ButtonType.disabled_navigation,
                    //     buttonText: 'Continue Shopping',
                    //     onTap: () {
                    //       if (verified) {
                    //         Navigator.of(context)
                    //             .push(MaterialPageRoute(builder: (_) {
                    //           return MainPage();
                    //         }));
                    //       }
                    //     })
                  ])
                ]))));
  }
}
