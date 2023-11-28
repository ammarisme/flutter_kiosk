import 'package:ecommerce_app/test.dart';
import 'package:flutter/material.dart';
import 'information_pages/terms_and_conditions.dart';
import 'test_page.dart'; // Import the test page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(), // Set the main page as the initial route
      routes: {
        '/testPage': (context) => TestPage(),
        '/test': (context) => TermsAndConditionsPage()// Define a route to the test page
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the test page when the button is pressed
            Navigator.pushNamed(context, '/testPage');
          },
          child: Text('Go to Test Page'),
        ),
      ),
    );
  }
}
