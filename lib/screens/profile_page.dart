import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/screens/settings/settings_page.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfilePage extends StatelessWidget {
  User logged_in_user;
  Function logout;

  ProfilePage( {
    required this.logged_in_user, required this.logout
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white, // Adjust as needed
              child: IconButton(
                icon: Icon(Icons.exit_to_app),
                color: Colors.black, // Adjust as needed
                onPressed: () {
                  this.logout();
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding:
            EdgeInsets.only(left: 16.0, right: 16.0, top: kToolbarHeight),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 48,
                  backgroundImage: NetworkImage(this.logged_in_user.avatar_url),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${this.logged_in_user.first_name} ${this.logged_in_user.last_name}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  title: Text('My past order'),
                  subtitle: Text('See your past orders & re-order.'),
                  leading: Image.asset(
                    'assets/icons/orders_icon.png', fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,),
                  trailing: Icon(Icons.chevron_right, color: PAGE_BACKGROUND_COLOR),
                  onTap: () => {}
                    
                ),
                 ListTile(
                  title: Text('Loyalty & Rewards'),
                  subtitle: Text('Earn points & save more'),
                  leading: Image.asset(
                    'assets/icons/orders_icon.png', fit: BoxFit.scaleDown,
                    width: 30,
                    height: 30,),
                  trailing: Icon(Icons.chevron_right, color: PAGE_BACKGROUND_COLOR),
                  onTap: () =>{}
                    
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


        // Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Image.asset('assets/icons/wallet.png'),
        //                       onPressed: () =>
        //                           Navigator.of(context).push(
        //                               MaterialPageRoute(
        //                                   builder: (_) => WalletPage())),
        //                     ),
        //                     Text(
        //                       'Wallet',
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     )
        //                   ],
        //                 ), //TODO : Wallet
        //                 Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Image.asset('assets/icons/truck.png'),
        //                       onPressed: () =>
        //                           Navigator.of(context).push(
        //                               MaterialPageRoute(
        //                                   builder: (_) => TrackingPage())),
        //                     ),
        //                     Text(
        //                       'Tracking',
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     )
        //                   ],
        //                 ),
        //                 Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Image.asset('assets/icons/card.png'),
        //                       onPressed: () =>
        //                           Navigator.of(context).push(
        //                               MaterialPageRoute(
        //                                   builder: (_) => PaymentPage())),
        //                     ),
        //                     Text(
        //                       'Payment',
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     )
        //                   ],
        //                 ),
        //                 Column(
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: <Widget>[
        //                     IconButton(
        //                       icon: Image.asset('assets/icons/contact_us.png'),
        //                       onPressed: () {},
        //                     ),
        //                     Text(
        //                       'Support',
        //                       style: TextStyle(fontWeight: FontWeight.bold),
        //                     )
        //                   ],
        //                 ),
