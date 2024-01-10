import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/data/data.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/address/select_shipping_and_payment_methods.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool shippingAndBillingInfoAreSane= true;

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
                      this.user!.phone_number  = value;
                    })},
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
                  fieldType: TextFieldType.text,
                  placeholder_text: 'House/Flat Number (eg:- 34/2 A)',
                  onChange: (value) =>
                      {
                        setState(() {
                      this.user!.shipping_info.address_1 = value;
                    })
                        },
                  icon: Icon(Icons.house),
                  defaultValue: user!.shipping_info.address_1,
                ),
                CustomTextField(
                  fieldType: TextFieldType.text,
                    placeholder_text: 'Street name (eg:- Prince Street',
                    onChange: (value) =>
                        {
                           setState(() {
                      user!.shipping_info.address_2 = value;
                    })
                          },
                    icon: Icon(Icons.add_road),
                    defaultValue: user!.shipping_info.address_2),

                CustomDropDownField(
                    input_list: data_districtsCities.getDistricts(),
                    placeholder_text: 'Select District',
                    onChange: (value) {
                      setState(() {
                        selectedDistrict = value;
                        selectedCity = "";
                        user!.shipping_info.state = value as String;
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
                      });
                    },
                    defaultValue: user!.shipping_info.city,
                    icon: Icon(Icons.place)),

                Row(
                  children: <Widget>[
                    Checkbox(
                      value: true,
                      onChanged: (value) {
                        shippingAndBillingInfoAreSane = value as bool;
                        if (value == true) {
                          user!.shipping_info.address_1 = user!.billing_info.address_1;
                          user!.shipping_info.address_2 = user!.billing_info.address_2;
                          user!.shipping_info.city = user!.billing_info.city;
                          user!.shipping_info.country = user!.billing_info.country;
                          user!.shipping_info.first_name = user!.billing_info.first_name;
                          user!.shipping_info.last_name = user!.billing_info.last_name;
                          user!.shipping_info.postcode = user!.billing_info.postcode;
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
                          CartNotifier cartNotifier =
                                Provider.of<CartNotifier>(context,
                                    listen: false);
                          cartNotifier.addCustomer(this.user);
                          if (user!.id == 0) {
                            //create a customer
                            UserAPIs.createCustomer(this.user as User)
                                .then((value) {
                              if (value.status == true) {
                                Utils.showToast("Created an account!",
                                    ToastType.done_success);
                                setState(() {
                                  user!.id = value.result.id;
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        SelectShippingMethodPage()));
                              }
                            });
                          } else {
                            UserAPIs.updateCustomer(this.user as User)
                                .then((value) {
                              Utils.showToast("Updated customer info!",
                                  ToastType.done_success);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => SelectShippingMethodPage()));
                            });
                          }
                        }))
              ],
            ),
          );
  }
}
