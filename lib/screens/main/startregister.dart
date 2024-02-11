import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:fluter_kiosk/api_services/sms_apis.dart';
import 'package:fluter_kiosk/api_services/user_apis.dart';
import 'package:fluter_kiosk/app_properties.dart';
import 'package:fluter_kiosk/common/utils.dart';
import 'package:fluter_kiosk/models/user.dart';
import 'package:fluter_kiosk/screens/components/ui_components.dart';
import 'package:fluter_kiosk/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:socket_io_client/src/socket.dart';

class StartRegister extends StatefulWidget {
  Socket socket;
  StartRegister({required this.socket});

  @override
  _StartRegisterState createState() => _StartRegisterState();
}

class _StartRegisterState extends State<StartRegister> {
  StartRegisterVM startRegisterVM = StartRegisterVM();

  @override
  void initState() {
    super.initState();
    startRegisterVM.socket = widget.socket;
    startRegisterVM.loadLocalSettings(() {
      setState(() {
        print(startRegisterVM.settings);
      });
    });
    // Make API call here
  }

  logout() {
    setState(() {
      startRegisterVM.email.text = "";
      startRegisterVM.username.text = "";
      startRegisterVM.user = null;
      startRegisterVM.showOtp = false;
      startRegisterVM.isRegistering = false;
      startRegisterVM.verified = false;
    });
  }

  userRegistered(user) {
    setState(() {
      startRegisterVM.user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return startRegisterVM.user != null
        ? (startRegisterVM.settings != null
            ? ProfilePage(
                logged_in_user: startRegisterVM.user as User, logout: logout)
            : Container())
        : (startRegisterVM.settings != null
            ? RegisterSigninPage(
                viewModel: startRegisterVM,
                reset: logout,
                userRegistered: userRegistered)
            : Container());
  }
}

class StartRegisterVM {
  bool verified = false;
  int? otp;
  bool showOtp = false;
  bool isRegistering = false;
  User? user;
  Socket? socket;
  dynamic settings;

  TextEditingController username = TextEditingController(text: '');
  TextEditingController firstname = TextEditingController(text: '');

  TextEditingController lastname = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');

  notifyBackend() {
    this.socket!.emit("chat message", [user?.id]);
  }

  showOTPVerification(_RegisterSigninPageState context, status) {
    context.setState(() {
      this.showOtp = status;
    });
  }

  void loadLocalSettings(Function callback) {
    Utils.getLocalSettings().then((value) {
      this.settings = json.decode(value as String);
      callback();
    });
  }
}

class RegisterSigninPage extends StatefulWidget {
  Function reset;
  Function userRegistered;
  StartRegisterVM viewModel;
  RegisterSigninPage(
      {required this.viewModel,
      required this.reset,
      required this.userRegistered});

  @override
  _RegisterSigninPageState createState() => _RegisterSigninPageState();
}

class _RegisterSigninPageState extends State<RegisterSigninPage> {
  StartRegisterVM startRegisterVM = StartRegisterVM();

  reset() {
    setState(() {
      startRegisterVM.email.text = "";
      startRegisterVM.username.text = "";
      startRegisterVM.user = null;
      startRegisterVM.showOtp = false;
      startRegisterVM.isRegistering = false;
    });
  }

  @override
  void initState() {
    super.initState();
    startRegisterVM = widget.viewModel;
    // Make API call here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF9F9F9),
          elevation: 0.0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white, // Adjust as needed
                child: IconButton(
                  icon: Icon(Icons.restart_alt),
                  color: Colors.black, // Adjust as needed
                  onPressed: () {
                    reset();
                  },
                ),
              ),
            ),
          ],
        ),
        body: Container(
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
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                  controller: startRegisterVM.username,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: 16.0),
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: InputBorder.none,
                                    fillColor: TEXT_BOX_COLOR,
                                    hintText: 'Mobile number',
                                    prefixIcon: Icon(
                                        Icons.phone), // Icon before the input
                                  ))),
                          ((startRegisterVM.settings["otpenabled"] && startRegisterVM.showOtp == true) || (!startRegisterVM.settings["otpenabled"] && startRegisterVM.isRegistering) )
                              ? Column(
                                  children: [
                                    startRegisterVM.isRegistering == true
                                        ? Padding(
                                            padding: EdgeInsets.all(10),
                                            child: TextField(
                                                controller:
                                                    startRegisterVM.firstname,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  border: InputBorder.none,
                                                  fillColor: TEXT_BOX_COLOR,
                                                  hintText: 'First Name',
                                                  prefixIcon: Icon(Icons
                                                      .person), // Icon before the input
                                                )))
                                        : Container(),
                                    startRegisterVM.isRegistering == true
                                        ? Padding(
                                            padding: EdgeInsets.all(10),
                                            child: TextField(
                                                controller:
                                                    startRegisterVM.lastname,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  border: InputBorder.none,
                                                  fillColor: TEXT_BOX_COLOR,
                                                  hintText: 'Last Name',
                                                  prefixIcon: Icon(Icons
                                                      .person), // Icon before the input
                                                )))
                                        : Container(),
                                    startRegisterVM.isRegistering == true
                                        ? Padding(
                                            padding: EdgeInsets.all(10),
                                            child: TextField(
                                                controller:
                                                    startRegisterVM.email,
                                                style:
                                                    TextStyle(fontSize: 16.0),
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  border: InputBorder.none,
                                                  fillColor: TEXT_BOX_COLOR,
                                                  hintText: 'Email',
                                                  prefixIcon: Icon(Icons
                                                      .email), // Icon before the input
                                                )))
                                        : Container(),

                                         (startRegisterVM.settings["otpenabled"]) ?Column( children : [
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
                                          if (!startRegisterVM.verified &
                                              startRegisterVM.isRegistering) {
                                            //create a customer
                                            User user = User(
                                                id: 0,
                                                email:
                                                    startRegisterVM.email.text,
                                                first_name: startRegisterVM
                                                    .firstname.text,
                                                last_name: startRegisterVM
                                                    .lastname.text,
                                                role: "",
                                                username: startRegisterVM
                                                    .username.text,
                                                billing_info: BillingInfo(
                                                    company: "",
                                                    email: startRegisterVM
                                                        .email.text,
                                                    phone: startRegisterVM
                                                        .username.text,
                                                    first_name: startRegisterVM
                                                        .firstname.text,
                                                    last_name: startRegisterVM
                                                        .lastname.text,
                                                    address_1: "",
                                                    address_2: "",
                                                    city: "",
                                                    postcode: '',
                                                    country: "",
                                                    state: ""),
                                                shipping_info: ShippingInfo(
                                                    address_1: "",
                                                    address_2: "",
                                                    city: "",
                                                    state: ""),
                                                avatar_url: "",
                                                phone_number: startRegisterVM
                                                    .username.text);
                                            UserAPIs.createCustomer(user)
                                                .then((value) {
                                              setState(() {
                                                startRegisterVM.user =
                                                    value.result;
                                                startRegisterVM.isRegistering =
                                                    false;
                                                startRegisterVM.verified = true;
                                                startRegisterVM.showOtp = false;
                                                startRegisterVM.notifyBackend();
                                              });
                                            });
                                          } else if ((startRegisterVM.verified &
                                              !startRegisterVM.isRegistering)) {
                                            //loging in
                                            Utils.showToast(
                                                "OTP verified. Let's play!",
                                                ToastType.done_success);
                                            UserAPIs.getUserByUsername(
                                                    startRegisterVM
                                                        .username.text)
                                                .then((value) {
                                              widget.userRegistered(value);
                                              startRegisterVM.notifyBackend();
                                            });
                                          } else {
                                            Utils.showToast(
                                                "OTP verification failed",
                                                ToastType.done_success);
                                          }
                                        },
                                        otpFieldStyle: OtpFieldStyle(
                                          borderColor: Colors.black,
                                        )),
                                         ]) : Container(),
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
                                              if (startRegisterVM
                                                  .settings["otpenabled"]) {
                                                //do OTP
                                                startRegisterVM.otp =
                                                    Random().nextInt(9000) +
                                                        1000;
                                                print(startRegisterVM.otp);
                                                SMSAPIs.sendSMS(
                                                        startRegisterVM
                                                            .username.text,
                                                        "Your OTP is " +
                                                            startRegisterVM.otp
                                                                .toString())
                                                    .then((value) {
                                                  if (value.status == true) {
                                                    startRegisterVM
                                                        .showOTPVerification(
                                                            this, true);
                                                    Utils.showToast(
                                                        "OTP sent to ${startRegisterVM.username.text}. Please check your SMS inbox.",
                                                        ToastType.done_success);
                                                  }
                                                });
                                              } else if (!startRegisterVM
                                                  .isRegistering) {
                                                //(startRegisterVM.verified &
                                                //loging in
                                             
                                                UserAPIs.getUserByUsername(
                                                        startRegisterVM
                                                            .username.text)
                                                    .then((value) {
                                                  widget.userRegistered(value);
                                                  startRegisterVM
                                                      .notifyBackend();
                                                });
                                              }

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
                                              if (startRegisterVM
                                                  .settings["otpenabled"] && !startRegisterVM.verified) {
 ///OTP scenario
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
                                                    
                                              } else if (startRegisterVM.verified) {
                                                //!startRegisterVM.verified &
                                                //create a customer
                                                User user = User(
                                                    id: 0,
                                                    email: startRegisterVM
                                                        .email.text,
                                                    first_name: startRegisterVM
                                                        .firstname.text,
                                                    last_name: startRegisterVM
                                                        .lastname.text,
                                                    role: "",
                                                    username: startRegisterVM
                                                        .username.text,
                                                    billing_info: BillingInfo(
                                                        company: "",
                                                        email: startRegisterVM
                                                            .email.text,
                                                        phone: startRegisterVM
                                                            .username.text,
                                                        first_name:
                                                            startRegisterVM
                                                                .firstname.text,
                                                        last_name: startRegisterVM
                                                            .lastname.text,
                                                        address_1: "",
                                                        address_2: "",
                                                        city: "",
                                                        postcode: '',
                                                        country: "",
                                                        state: ""),
                                                    shipping_info: ShippingInfo(
                                                        address_1: "",
                                                        address_2: "",
                                                        city: "",
                                                        state: ""),
                                                    avatar_url: "",
                                                    phone_number: startRegisterVM
                                                        .username.text);
                                                UserAPIs.createCustomer(user)
                                                    .then((value) {
                                                  setState(() {
                                                    startRegisterVM.user =
                                                        value.result;
                                                    startRegisterVM
                                                        .isRegistering = false;
                                                    startRegisterVM.verified =
                                                        true;
                                                    startRegisterVM.showOtp =
                                                        false;
                                                    startRegisterVM
                                                        .notifyBackend();
                                                  });
                                                  widget.userRegistered(
                                                      value.result);
                                                });
                                              } else if(!startRegisterVM.settings["otpenabled"]){
                                                 setState(() {
                                                    startRegisterVM.showOtp =false;
                                                    startRegisterVM.verified = true;
                                                    startRegisterVM.isRegistering = true;
                                                  });
                                              }
                                            },
                                            buttonType: ButtonType
                                                .disabled_navigation)),
                                  ],
                                )
                              : Container()
                        ])))));
  }
}
