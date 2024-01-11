import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:ecommerce_int2/api_services/sms_apis.dart';
import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/data/data.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/address/address_form.dart';
import 'package:ecommerce_int2/screens/address/select_shipping_and_payment_methods.dart';
import 'package:ecommerce_int2/screens/auth/confirm_otp_page.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:ecommerce_int2/screens/main/main_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/settings.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  Widget registrationForm = RegistrationForm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: darkGrey),
        title: Text(
          'Sign up',
          style: const TextStyle(
              color: darkGrey,
              fontWeight: FontWeight.w500,
              fontFamily: "Montserrat",
              fontSize: 18.0),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: MediaQuery.of(context).padding.bottom == 0
                      ? 20
                      : MediaQuery.of(context).padding.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[registrationForm],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///Registration form.

class RegistrationForm extends StatefulWidget {
  RegistrationForm();

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  bool isLoading = true;
  User? user;
  Data_DistrictsCities data_districtsCities = Data_DistrictsCities();
  String? selectedDistrict;
  String? selectedCity;
  bool shippingAndBillingInfoAreSane = true;

  @override
  void initState() {
    super.initState();
    data_districtsCities.loadJson();
    // Make API call here
    UserAPIs.getCurrentlyLoggedInUser().then((value) {
      setState(() {
        if (value.status == true) {
          user = value.result;
        } else {
          user = User(
              id: 0,
              email: '',
              first_name: '',
              last_name: '',
              role: '',
              username: '',
              billing_info: BillingInfo(
                  company: '',
                  email: '',
                  phone: '',
                  first_name: '',
                  last_name: '',
                  address_1: '',
                  address_2: '',
                  city: '',
                  postcode: '',
                  country: '',
                  state: ''),
              shipping_info: ShippingInfo(),
              avatar_url: '',
              phone_number: '');
        }
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return isLoading
        ? Center(
            child: CircularProgressIndicator(), // Or any other loader widget
          )
        : SizedBox(
            height: screenAwareSize(80, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextField(
                  key: _formKey,
                  fieldType: TextFieldType.text,
                  placeholder_text: 'First name (eg:- Jhon)',
                  onChange: (value) {
                    setState(() {
                      this.user!.first_name = value;
                    });
                  },
                  icon: Icon(Icons.person),
                  defaultValue: user!.first_name,
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  placeholder_text: 'Last name (eg:- Prince Street)',
                  onChange: (value) => {
                    setState(() {
                      this.user!.last_name = value;
                    })
                  },
                  icon: Icon(Icons.person),
                  defaultValue: user!.last_name,
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  placeholder_text: 'Phone number (eg:- 07773453434)',
                  onChange: (value) => {
                    setState(() {
                      this.user!.phone_number = Utils.cleanMobileNumber(value);
                    })
                  },
                  icon: Icon(Icons.person),
                  defaultValue: user!.phone_number,
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                  placeholder_text: 'Email (eg:- yourname@gmail.cm)',
                  onChange: (value) => {
                    setState(() {
                      this.user!.email = value;
                    })
                  },
                  icon: Icon(Icons.email),
                  defaultValue: user!.email,
                ),
                CustomTextField(
                  fieldType: TextFieldType.password,
                  placeholder_text: 'Password',
                  onChange: (value) => {
                    setState(() {
                      this.user!.password = value;
                    })
                  },
                  icon: Icon(Icons.lock),
                  defaultValue: user!.password,
                ),
                CustomTextField(
                  fieldType: TextFieldType.password,
                  placeholder_text: 'Confirm your password',
                  onChange: (value) => {
                    setState(() {
                      this.user!.password2 = value;
                    })
                  },
                  icon: Icon(Icons.lock),
                  defaultValue: user!.password2,
                ),
                Center(
                    child: ActionButton(
                        buttonType: ButtonType.enabled_default,
                        buttonText: 'Register now!',
                        onTap: () {
                          ValidationResult valResult =
                              validate(this.user as User);
                          if (valResult.status == false) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Invalid inputs found'),
                                    content: Container(
                                      width: double.maxFinite,
                                      height: screenAwareSize(60,
                                          context), // Set a fixed height (you can adjust this)
                                      child: ListView.builder(
                                        itemCount: valResult.errors.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            textColor: Colors.red,
                                            title:
                                                Text(valResult.errors[index]),
                                          );
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                });
                            return;
                          } else {
                            
                          this.user!.username = Utils.cleanMobileNumber(this.user!.phone_number) ;
                          //Send SMS.
                          Random random = Random();
                          int randomNumber = random.nextInt(9000) + 1000;

                          SMSAPIs.sendSMS(user!.phone_number,
                                  "Your OTP is " + randomNumber.toString())
                              .then((value) {
                            if (value.status == true) {
                              Utils.showToast(
                                  "OTP sent to ${user!.phone_number}. Please check your SMS inbox.",
                                  ToastType.done_success);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ConfirmOtpPage(
                                        user: (this.user as User),
                                        otp: randomNumber,
                                        postConfirmation: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => MainPage()
                                            ));
                                        },
                                      )));
                            } else {}
                          });

                            return;
                          }
                        }))
              ],
            ),
          );
  }
}

class ValidationResult {
  bool status = true;
  List errors = [];
}

validate(User user) {
  ValidationResult validationResults = ValidationResult();
  if (user.first_name.isEmpty) {
    validationResults.status = false;
    validationResults.errors.add("First name is required.");
  }
  if (user.last_name.isEmpty) {
    validationResults.status = false;
    validationResults.errors.add("Last name is required.");
  }
  String phone_number = Utils.cleanMobileNumber(user.phone_number);
  if (phone_number.isEmpty) {
    validationResults.status = false;
    validationResults.errors.add("Phone number is required.");
  } else if(phone_number.length != 11) {
    validationResults.status = false;
    validationResults.errors.add("Phone number has to be 11 digits long. (eg:- 94777123456)");
  }
  if (user.email.isEmpty) {
    validationResults.status = false;
    validationResults.errors.add("Email is required.");
  }
  if (user.password.isEmpty) {
    validationResults.status = false;
    validationResults.errors.add("Password is required.");
  } else if(user.password.length < 8) {
    validationResults.status = false;
    validationResults.errors.add("Password has to be at least 8 characters long.");
  }
  RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(user.email)) {
    validationResults.status = false;
    validationResults.errors.add("A valid email is required.");
  }
  if (user.password != user.password2) {
    validationResults.status = false;
    validationResults.errors.add("Passwords aren't matching.");
  }

  return validationResults;
}
