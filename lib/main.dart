import 'dart:async';

import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/change_notifiers/mainpage_notifier.dart';
import 'package:ecommerce_int2/change_notifiers/product_notifier.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  // Set up an error handler using runZonedGuarded
  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stackTrace) {
    // Print the error and stack trace
    print('Caught error: $error');
    print('Stack trace: $stackTrace');
  });
}

class MyApp extends StatelessWidget {

  


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainPageNotifier>(
          create: (_) => MainPageNotifier(),
        ),
        ChangeNotifierProvider<UserNotifier>(
          create: (_) => UserNotifier(),
        ),
        ChangeNotifierProvider<ProductNotifier>(
            create: (_) => ProductNotifier(),
        ),
        ChangeNotifierProvider<CartNotifier>(
          create: (_) => CartNotifier(),
        )
      ],
      child: MaterialApp(
      title: 'catlitter.lk',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        ////brightness: Brightness.light,
        canvasColor: Colors.transparent,
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: SplashScreen())
     );
     
  }
}
