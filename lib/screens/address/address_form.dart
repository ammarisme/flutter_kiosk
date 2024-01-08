import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/data/data.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/address/select_shipping_and_payment_methods.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
import 'package:flutter/material.dart';


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

@override
void initState() {
  super.initState();
  data_districtsCities.loadJson();
  // Make API call here
  UserAPIs.getCurrentlyLoggedInUser().then((value) {
    setState(() {
      user = value;
      isLoading = false;
    });
  }
  );
}

  @override
  Widget build(BuildContext context) {
    return isLoading? Center(
              child: CircularProgressIndicator(), // Or any other loader widget
            ):
    SizedBox(
              height: screenAwareSize(100, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomTextField(
                    placeholder_text: 'First name (eg:- Jhon)',
                    onChange: (value)
                        {
                          setState(() {
                          this.user!.first_name = value;
                          });
                          //cartNotifier.addOrUpdateFirstName(value)
                        },
                    icon: Icon(Icons.person),
                    defaultValue: user!.first_name,
                  ),
                  CustomTextField(
                    placeholder_text: 'Last name (eg:- Prince Street)',
                    onChange: (value) =>
                        {
                          //cartNotifier.addOrUpdateLastName(value)
                          },
                    icon: Icon(Icons.person),
                    defaultValue: user!.last_name,
                  ),
                  CustomTextField(
                    placeholder_text: 'House/Flat Number (eg:- 34/2 A)',
                    onChange: (value) =>
                        {
                          //cartNotifier.addOrUpdateAddress1(value)
                          },
                    icon: Icon(Icons.house),
                    defaultValue: user!.billing_info.address_1,
                  ),
                  CustomTextField(
                      placeholder_text: 'Street name (eg:- Prince Street',
                      onChange: (value) =>
                          {
                            //cartNotifier.addOrUpdateAddress2(value)
                            },
                      icon: Icon(Icons.add_road),
                      defaultValue: user!.billing_info.address_2),
                  // SearchableDropDown(
                  //   label: "",
                  //   hint: "",
                  //   selectableItems: Data.cities,
                  // ),
                   CustomDropDownField(
                      input_list: data_districtsCities.getDistricts(),
                      placeholder_text: 'Select District',
                      onChange: (value)
                          { 
                            setState(() {
                              selectedDistrict = value;
                              selectedCity = "";
                            });
                           
                            //cartNotifier.addOrUpdateStateOrProvince(value!)
                            },
                      defaultValue: "",
                      icon: Icon(Icons.location_city)),
                  //Street name
                  CustomDropDownField(
                      input_list:  selectedDistrict != null ? data_districtsCities.getCities(selectedDistrict as String) : [],
                      placeholder_text: 'Select City',
                      onChange: (value)
                          {
                            setState(() {
                              selectedCity = value;
                            });
                            },
                      defaultValue: "",
                      icon: Icon(Icons.place)),
                 
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: true,
                        onChanged: (value) {
                          if (value == true) {

                          } else {}
                        },
                      ),
                      Text('Use the same as the Billing address.')
                    ],
                  )
                 ,Center(child: ActionButton(
                      buttonText: 'Next',
                      onTap: () {
                        //TODO: do validations
                        //update the customer.
                        UserAPIs.updateCustomer(this.user as User);
                        //create a customer if customer doesn't exist
                        //copy shipping info to billing info if ticked.
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => SelectShippingMethodPage()));
                      }))
                ],
              ),
            );
  }
}