import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/data/data.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/address/select_shipping_and_payment_methods.dart';
import 'package:ecommerce_int2/screens/auth/confirm_otp_page.dart';
import 'package:ecommerce_int2/screens/auth/register_page.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_int2/api_services/sms_apis.dart';
import 'dart:math';

class AddAddressForm extends StatefulWidget {
  AddAddressForm();

  @override
  _AddAddressFormState createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  bool isLoading = true;
  User? user;
  Data_DistrictsCities data_districtsCities = Data_DistrictsCities();
  String? selectedDistrict;
  String? selectedCity;
  bool shippingAndBillingInfoAreSane = true;

  TextEditingController txtControllerfirstName = TextEditingController();
  TextEditingController txtControllerLastName = TextEditingController();
  TextEditingController txtControllerPhoneNumber = TextEditingController();
  TextEditingController txtControllerEmail = TextEditingController();
  TextEditingController txtControllerAddress1 = TextEditingController();
  TextEditingController txtControllerAddress2 = TextEditingController();

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
              shipping_info: ShippingInfo(
                city: "Select City",
                state: "Select District",
                address_1: '',
                address_2: '',
              ),
              avatar_url: '',
              phone_number: '');
        }
         selectedDistrict = user!.shipping_info.state;
          selectedCity = user!.shipping_info.city;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(), // Or any other loader widget
          )
        : SizedBox(
            height: screenAwareSize(120, context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextField(
                  textEditingController: txtControllerfirstName,
                  fieldType: TextFieldType.text,
                  placeholder_text: 'First name (eg:- Jhon)',
                  onChange: (value) {},
                  icon: Icon(Icons.person),
                  defaultValue: user!.first_name,
                ),
                CustomTextField(
                  textEditingController: txtControllerLastName,
                  fieldType: TextFieldType.text,
                  placeholder_text: 'Last name (eg:- Doe)',
                  onChange: (value) => {},
                  icon: Icon(Icons.person),
                  defaultValue: user!.last_name,
                ),
                CustomTextField(
                  textEditingController: txtControllerPhoneNumber,
                  fieldType: this.user!.id > 0
                      ? TextFieldType.disabled
                      : TextFieldType.text,
                  placeholder_text: 'Mobile number (eg:- 94777123456)',
                  onChange: (value) => {},
                  icon: Icon(Icons.person),
                  defaultValue:
                      this.user!.id > 0 ? user!.username : user!.phone_number,
                ),
                CustomTextField(
                  textEditingController: txtControllerEmail,
                  fieldType: this.user!.id > 0
                      ? TextFieldType.disabled
                      : TextFieldType.text,
                  placeholder_text: 'Email (eg:- yourname@gmail.com)',
                  onChange: (value) => {},
                  icon: Icon(Icons.email),
                  defaultValue: user!.email,
                ),
                CustomTextField(
                  textEditingController: txtControllerAddress1,
                  fieldType: TextFieldType.text,
                  placeholder_text: 'House/Flat Number (eg:- 34/2 A)',
                  onChange: (value) => {},
                  icon: Icon(Icons.house),
                  defaultValue: user!.shipping_info.address_1,
                ),
                CustomTextField(
                    textEditingController: txtControllerAddress2,
                    fieldType: TextFieldType.text,
                    placeholder_text: 'Street name (eg:- Ward Place)',
                    onChange: (value) => {},
                    icon: Icon(Icons.add_road),
                    defaultValue: user!.shipping_info.address_2),

                CustomDropDownField(
                    input_list: data_districtsCities.getDistricts(),
                    placeholder_text: 'Select District',
                    onChange: (value) {
                      setState(() {
                        selectedDistrict = value;
                        selectedCity = "Select City";
                        user!.shipping_info.state = value as String;
                        this.user!.first_name = txtControllerfirstName.text;
                          this.user!.last_name = txtControllerLastName.text;
                          this.user!.phone_number =
                              txtControllerPhoneNumber.text;
                          this.user!.email = txtControllerEmail.text;
                          this.user!.shipping_info.address_1 =
                              txtControllerAddress1.text;
                          this.user!.shipping_info.address_2 =
                              txtControllerAddress2.text;

                          if(this.user!.shipping_info.city == "Select City"){
                            this.user!.shipping_info.city  == "";
                          }
                          if(this.user!.shipping_info.state == "Select District"){
                            this.user!.shipping_info.state  == "";
                          }
                           if(this.user!.billing_info.city == "Select City"){
                            this.user!.billing_info.city  == "";
                          }
                          if(this.user!.billing_info.state == "Select District"){
                            this.user!.billing_info.state  == "";
                          }
                      });
                    },
                    defaultValue: user!.shipping_info.state,
                    icon: Icon(Icons.location_city)),
                //Street name
                CustomDropDownField(
                    input_list: selectedDistrict != null
                        ? data_districtsCities
                            .getCities(selectedDistrict as String)
                        : [],
                    placeholder_text: 'Select City',
                    onChange: (value) {
                      setState(() {
                        selectedCity = value;
                        user!.shipping_info.city = value as String;
                        this.user!.first_name = txtControllerfirstName.text;
                          this.user!.last_name = txtControllerLastName.text;
                          this.user!.phone_number =
                              txtControllerPhoneNumber.text;
                          this.user!.email = txtControllerEmail.text;
                          this.user!.shipping_info.address_1 =
                              txtControllerAddress1.text;
                          this.user!.shipping_info.address_2 =
                              txtControllerAddress2.text;

                          if(this.user!.shipping_info.city == "Select City"){
                            this.user!.shipping_info.city  == "";
                          }
                          if(this.user!.shipping_info.state == "Select District"){
                            this.user!.shipping_info.state  == "";
                          }
                           if(this.user!.billing_info.city == "Select City"){
                            this.user!.billing_info.city  == "";
                          }
                          if(this.user!.billing_info.state == "Select District"){
                            this.user!.billing_info.state  == "";
                          }
                      });
                    },
                    defaultValue: selectedCity as String,
                    icon: Icon(Icons.place)),

                Row(
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      onChanged: (value) {
                        shippingAndBillingInfoAreSane = value as bool;
                        if (value == true) {
                          user!.shipping_info.address_1 =
                              user!.billing_info.address_1;
                          user!.shipping_info.address_2 =
                              user!.billing_info.address_2;
                          user!.shipping_info.city = user!.billing_info.city;
                          user!.shipping_info.country =
                              user!.billing_info.country;
                          user!.shipping_info.first_name =
                              user!.billing_info.first_name;
                          user!.shipping_info.last_name =
                              user!.billing_info.last_name;
                          user!.shipping_info.postcode =
                              user!.billing_info.postcode;
                          user!.shipping_info.state = user!.billing_info.state;
                        }
                      },
                    ),
                    Text('Use the same info for Billing.')
                  ],
                ),
                Container(
                  child: Text(
                      "(We'll create an account for you with these information.)"),
                  padding: EdgeInsets.only(left: 16.0, top: 4.0, bottom: 4.0),
                ),
                Center(
                    child: ActionButton(
                        buttonType: ButtonType.enabled_default,
                        buttonText: 'Next',
                        onTap: () {
                          this.user!.first_name = txtControllerfirstName.text;
                          this.user!.last_name = txtControllerLastName.text;
                          this.user!.phone_number =
                              txtControllerPhoneNumber.text;
                          this.user!.email = txtControllerEmail.text;
                          this.user!.shipping_info.address_1 =
                              txtControllerAddress1.text;
                          this.user!.shipping_info.address_2 =
                              txtControllerAddress2.text;

                          if(this.user!.shipping_info.city == "Select City"){
                            this.user!.shipping_info.city  == "";
                          }
                          if(this.user!.shipping_info.state == "Select District"){
                            this.user!.shipping_info.state  == "";
                          }
                           if(this.user!.billing_info.city == "Select City"){
                            this.user!.billing_info.city  == "";
                          }
                          if(this.user!.billing_info.state == "Select District"){
                            this.user!.billing_info.state  == "";
                          }

                          ValidationResult valResult =
                              validate(this.user as User);
                              ValidationResult valShippingInfo =
                              validateShippingInfo(this.user as User);
                              
                          if (valResult.status && valShippingInfo.status== false) {
                            valResult.errors.addAll(valShippingInfo.errors);
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
                          }

                          if (user!.id > 0) {
                            CartNotifier cartNotifier =
                                Provider.of<CartNotifier>(context,
                                    listen: false);
                            cartNotifier.addCustomer(this.user);
                            UserAPIs.updateCustomer(this.user as User)
                                .then((value) {
                              Utils.showToast("Updated customer info!",
                                  ToastType.done_success);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SelectShippingMethodPage()));
                            });
                          } else {
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
                                            CartNotifier cartNotifier =
                                                Provider.of<CartNotifier>(
                                                    context,
                                                    listen: false);
                                            cartNotifier.addCustomer(this.user);
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        SelectShippingMethodPage()));
                                          },
                                        )));
                              } else {}
                            });
                          }
                        }))
              ],
            ),
          );
  }
}
