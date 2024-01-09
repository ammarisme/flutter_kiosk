import 'package:ecommerce_int2/api_services/user_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/data/data.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:ecommerce_int2/screens/address/address_form.dart';
import 'package:ecommerce_int2/screens/address/select_shipping_and_payment_methods.dart';
import 'package:ecommerce_int2/screens/components/ui_components.dart';
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
                children: <Widget>[
                  registrationForm 
                ],
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
            height: screenAwareSize(80, context),
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
                        buttonText: 'Register now!',
                        onTap: () {
                            this.user!.username = this.user!.phone_number;
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
                                        ProfilePage(logged_in_user: (this.user as User))));
                              }else{
                                 Utils.showToast((value.error_message as String),
                                    ToastType.done_error);
                              }
                            });
                        }))
              ],
            ),
          );
  }
}
