import 'dart:math';

  import 'package:ecommerce_int2/api_services/sms_apis.dart';
  import 'package:ecommerce_int2/api_services/user_apis.dart';
  import 'package:ecommerce_int2/app_properties.dart';
  import 'package:ecommerce_int2/common/utils.dart';
  import 'package:ecommerce_int2/models/user.dart';
  import 'package:ecommerce_int2/screens/components/ui_components.dart';
  import 'package:ecommerce_int2/screens/profile_page.dart';
  import 'package:flutter/material.dart';
  import 'package:otp_text_field/otp_field.dart';
  import 'package:otp_text_field/otp_field_style.dart';

  class StartRegister extends StatefulWidget {
    StartRegister();

    @override
    _StartRegisterState createState() => _StartRegisterState();
  }

  class _StartRegisterState extends State<StartRegister> {
    StartRegisterVM startRegisterVM = StartRegisterVM();

    @override
    void initState() {
      super.initState();
      // Make API call here
    }

logout(){
  setState(() {
    startRegisterVM.user = null;
    startRegisterVM.showOtp = false;
    startRegisterVM.isRegistering = false;
  });
    
  }
    @override
    Widget build(BuildContext context) {
      return startRegisterVM.user != null
          ? ProfilePage(logged_in_user: startRegisterVM.user as User, logout: logout)
          : Container(
              color: Colors.grey.shade300,
              height: double.infinity,
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              child: new Image.asset('assets/logo.png'),
                            ),
                            Padding(padding: EdgeInsets.all(10), child: TextField(
                                controller: startRegisterVM.username,
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: TEXT_BOX_COLOR,
                                  hintText: 'Mobile number',
                                  prefixIcon:
                                      Icon(Icons.phone), // Icon before the input
                                ))),
                          
                            (startRegisterVM.showOtp == true)
                                ? Column(
                                    children: [
                                      startRegisterVM.isRegistering==true?  Padding(padding: EdgeInsets.all(10), child: TextField(
                                        controller: startRegisterVM.firstname,
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: TEXT_BOX_COLOR,
                                  hintText: 'First Name',
                                  prefixIcon:
                                      Icon(Icons.person), // Icon before the input
                                ))) : Container(),
                                startRegisterVM.isRegistering==true?   Padding(padding: EdgeInsets.all(10), child: TextField(
                                  controller: startRegisterVM.lastname,
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: TEXT_BOX_COLOR,
                                  hintText: 'Last Name',
                                  prefixIcon:
                                      Icon(Icons.person), // Icon before the input
                                ))) : Container(),
                                startRegisterVM.isRegistering==true?   Padding(padding: EdgeInsets.all(10), child: TextField(
                                  controller: startRegisterVM.email,
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  filled: true,
                                  border: InputBorder.none,
                                  fillColor: TEXT_BOX_COLOR,
                                  hintText: 'Email',
                                  prefixIcon:
                                      Icon(Icons.email), // Icon before the input
                                ))) : Container(),
                                      Text(
                                        "Enter verification code sent via SMS to " +
                                            startRegisterVM.username.text,
                                      ),
                                      SizedBox(
                                        height: screenAwareSize(10, context),
                                      ),
                                      OTPTextField(
                                          length: 4,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fieldWidth: 50,
                                          style: TextStyle(fontSize: 17),
                                          textFieldAlignment:
                                              MainAxisAlignment.spaceAround,
                                          onCompleted: (pin) {
                                            startRegisterVM.verified = (pin ==
                                                startRegisterVM.otp.toString());
                                            if(!startRegisterVM.verified & startRegisterVM.isRegistering){
//create a customer
User user =  User(id: 0, email: startRegisterVM.email.text, first_name: startRegisterVM.firstname.text, last_name: startRegisterVM.lastname.text,
role: "", username: startRegisterVM.username.text, 
billing_info:  BillingInfo(company: "", email: startRegisterVM.email.text, phone: startRegisterVM.username.text, first_name: startRegisterVM.firstname.text,
last_name: startRegisterVM.lastname.text, address_1: "", address_2: "", city: "", postcode: '', country: "", state: "")
, shipping_info: ShippingInfo(address_1: "", address_2: "", city: "", state: "")
, avatar_url: "", phone_number: startRegisterVM.username.text);
    // Utils.showToast(
    //                                             "OTP verified. Creating a profile for you",
    //                                             ToastType.done_success);
                                            UserAPIs.createCustomer(
                                                    user)
                                                .then((value) {
                                              setState(() {
                                                startRegisterVM.user = value.result;
                                                startRegisterVM.isRegistering = false;
                                                startRegisterVM.verified = true;
                                                startRegisterVM.showOtp = false;
                                              });
                                            });
                                            }else if((startRegisterVM.verified & !startRegisterVM.isRegistering)){
                                              //loging in
                                                Utils.showToast(
                                                "OTP verified. Let's play!",
                                                ToastType.done_success);
                                            UserAPIs.getUserByUsername(
                                                    startRegisterVM.username.text)
                                                .then((value) {
                                              setState(() {
                                                startRegisterVM.user = value;
                                              });
                                            });
                                              
                                            }else{
                                              Utils.showToast(
                                                  "OTP verification failed",
                                                  ToastType.done_success);
                                            }
                                          },
                                          otpFieldStyle: OtpFieldStyle(
                                            borderColor: Colors.black,
                                          )),
                                      SizedBox(
                                        height: screenAwareSize(10, context),
                                      ),
                                                                  ],
                                  )
                                : Container(),
                            (startRegisterVM.showOtp == false)
                                ? Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10),
                                          child: ActionButton(
                                              buttonText: "Sign in",
                                              onTap: () {
                                                //do OTP
                                                startRegisterVM.otp =
                                                    Random().nextInt(9000) + 1000;
                                                SMSAPIs.sendSMS(
                                                        startRegisterVM.username.text,
                                                        "Your OTP is " +
                                                            startRegisterVM.otp
                                                                .toString())
                                                    .then((value) {
                                                  if (value.status == true) {
                                                    setState(() {
                                                      startRegisterVM.showOtp =
                                                          true;
                                                    });
                                                    Utils.showToast(
                                                        "OTP sent to ${startRegisterVM.username.text}. Please check your SMS inbox.",
                                                        ToastType.done_success);
                                                  }
                                                });
                                                //if OTP was successful, do register.
                                                //once registered, enable the spin game.
                                              },
                                              buttonType:
                                                  ButtonType.enabled_default)),
                                      Padding(
                                          padding: EdgeInsets.all(10),
                                          child: ActionButton(
                                              buttonText: "Register",
                                              onTap: () {
                                                int randomNumber =
                                                    Random().nextInt(9000) + 1000;
                                                SMSAPIs.sendSMS(
                                                        startRegisterVM.username.text,
                                                        "Your OTP is " +
                                                            randomNumber
                                                                .toString())
                                                    .then((value) {
                                                  if (value.status == true) {
                                                    setState(() {
                                                      startRegisterVM.showOtp =
                                                          true;
                                                      startRegisterVM.verified =
                                                          false;
                                                      startRegisterVM
                                                          .isRegistering = true;
                                                    });
                                                  } else {}
                                                });
                                              },
                                              buttonType: ButtonType
                                                  .disabled_navigation)),
                                    ],
                                  )
                                : Container()
                          ]))));
    }
  }

  class StartRegisterVM {
    bool verified = false;
    int? otp;
    bool showOtp = false;
    bool isRegistering = false;
    User? user;

      TextEditingController username = TextEditingController(text: '');
          TextEditingController firstname = TextEditingController(text: '');

      TextEditingController lastname = TextEditingController(text: '');
      TextEditingController email = TextEditingController(text: '');
      

  }
