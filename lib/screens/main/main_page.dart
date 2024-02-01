
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/custom_background.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/auth/login_page.dart';
import 'package:ecommerce_int2/screens/main/game.dart';
import 'package:ecommerce_int2/screens/main/startregister.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../change_notifiers/mainpage_notifier.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: MainContent(),
      );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent>
    with TickerProviderStateMixin<MainContent> {
  TabController? tabController;
  TabController? bottomTabController;
  bool isStateUpdated = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 10, vsync: this);
    bottomTabController = TabController(length: 10, vsync: this);
    print('initState');
    if (!isStateUpdated) {
      setState(() {
        isStateUpdated = true;
      });
    }
   
  }

  @override
  Widget build(BuildContext context) {
    print('building');
    MainPageNotifier mainPageNotifier = Provider.of<MainPageNotifier>(context, listen: true);
  
    return Scaffold(
      body : 
    Row(
        children: [ 
          Expanded(
            flex: 1,
            child:  Game(),
          
          ),
          Expanded(
            flex: 1,
            child:  StartRegister(),
          )
          
          
        ],
      ),  
    );
  }
}


// return Scaffold(
//       body: CustomPaint(
//           painter: MainBackground(),
//           child: TabBarView(
//             controller: bottomTabController,
//             physics: NeverScrollableScrollPhysics(),
//             children: <Widget>[
//               Consumer<UserNotifier>(
//                 builder: (context, userNotifier, _) { 
//                   return Container(
//                       child: LoginOrProfile() );
//                 },
//               )
//             ],
//           )),
//     );
