import 'dart:convert';

import 'package:fluter_kiosk/app_properties.dart';
import 'package:fluter_kiosk/change_notifiers/user_notifier.dart';
import 'package:fluter_kiosk/common/utils.dart';
import 'package:fluter_kiosk/custom_background.dart';
import 'package:fluter_kiosk/models/product.dart';
import 'package:fluter_kiosk/screens/auth/login_page.dart';
import 'package:fluter_kiosk/screens/main/game.dart';
import 'package:fluter_kiosk/screens/main/startregister.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../change_notifiers/mainpage_notifier.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:http/http.dart' as http;

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  IO.Socket socket = io(
      'http://ec2-13-234-20-8.ap-south-1.compute.amazonaws.com:4002',
      OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .disableAutoConnect() // disable auto-connection
          .setExtraHeaders({'foo': 'bar'}) // optional
          .build());

  MainPageVm viewModel = MainPageVm();
  @override
  void initState() {
    super.initState();

    viewModel.checkSettings().then((expired) {
      setState(() {
        viewModel.expired = expired;
      });
    });

    tabController = TabController(length: 10, vsync: this);
    bottomTabController = TabController(length: 10, vsync: this);
    if (!isStateUpdated) {
      setState(() {
        isStateUpdated = true;
      });
    }
    socket.connect();

    socket.onConnect((_) {
      print('connect');
      // socket.emit('chat message', 'new app connected');
    });
    socket.on('chat message', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));

    //banner timer
    viewModel.bannerTimer = Timer(Duration(seconds: 60*2), () {
      setState(() {
        viewModel.isBannerVisible = true;
      });
    });
  }

  void resetBannerTimer() {
    // Reset the timer when there is user activity
    viewModel.bannerTimer.cancel();
    viewModel.bannerTimer = Timer(Duration(seconds: 60), () {
      setState(() {
        viewModel.isBannerVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return viewModel.expired == true
        ? Container()
        : Stack(children: [
            Scaffold(
              body: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Game(socket),
                  ),
                  Expanded(
                    flex: 1,
                    child: StartRegister(socket: socket),
                  ),
                  // Display the promotional banner if it is visible
                ],
              ),
            ),
            (viewModel.isBannerVisible == true)
                ? GestureDetector(
                    onTap: () {
                      // Set the state to make the banner disappear
                      setState(() {
                        viewModel.isBannerVisible = false;
                      });
                      resetBannerTimer(); // Reset the timer on user activity
                    },
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.all(25.0), // Adjust margin as needed
                      child: FutureBuilder<String>(
                        future:
                            viewModel.fetchBannerUrl(this), // Fetch banner URL
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Add a loading indicator while fetching
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  viewModel.isBannerVisible = false;
                                });
                                resetBannerTimer(); // Reset the timer on user activity
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(25.0),
                                child: Image.network(
                                  snapshot.data!, // Use the fetched image URL
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  )
                : Container(),
          ]);
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    viewModel.bannerTimer.cancel();
    // Existing code...
    super.dispose();
  }
}

class MainPageVm {
  bool expired = false;
  late Timer bannerTimer;
  String backendApiUrl = "http://ec2-13-234-20-8.ap-south-1.compute.amazonaws.com:5001";

  bool isBannerVisible = true; // Track the visibility of the banner

  Future<String> fetchBannerUrl(_MainContentState state) async {
    try {
      final response = await http.get(
          Uri.parse(
              '${backendApiUrl}/promotions/1'),
          headers: {
            "Content-type": "application/x-www-form-urlencoded",
            "Accept": "text/html"
          });
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        if (data.isNotEmpty) {
          return data['banner_url'];
        }
      }
    } catch (ex) {
      print(ex);
    }

    return 'https://catlitter.lk/wp-content/uploads/2023/04/Post-Pc.jpg'; // Default image URL
  }

  Future<bool> checkSettings() async {
    final response = await http.get(
        Uri.parse(
            '${backendApiUrl}/settings/1'),
        headers: {
          "Content-type": "application/x-www-form-urlencoded",
          "Accept": "text/html"
        });

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> data = json.decode(response.body);

      //Save settings locally.
      Utils.saveSettings(response.body);

      // Return the value of the "expired" field
      return data['expired'];
    } else {
      // Throw an exception if the HTTP request fails
      return true;
    }
  }
}
