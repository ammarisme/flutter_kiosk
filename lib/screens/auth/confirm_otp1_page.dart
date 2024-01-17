import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';

class ConfirmOtp1Page extends StatefulWidget {
  final String phoneNumber;
  final int otp;
  final Function postConfirmation;
  ConfirmOtp1Page(
      {required this.phoneNumber, required this.otp, required this.postConfirmation});
  @override
  _ConfirmOtpPageState createState() => _ConfirmOtpPageState();
}

class _ConfirmOtpPageState extends State<ConfirmOtp1Page> {
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
                          widget.phoneNumber,
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
                            widget.postConfirmation();
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

                
                  ])
                ]))));
  }
}
