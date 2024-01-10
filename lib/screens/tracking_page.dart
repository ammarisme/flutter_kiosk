import 'package:ecommerce_int2/api_services/order_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/api_response.dart';
import 'package:ecommerce_int2/models/order.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrackingPage extends StatefulWidget {
  final User user;

  TrackingPage({required this.user});

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class OrderHistory {
  final Order order;

  List<Location> locations = [];

  OrderHistory({required this.order});

  List<Location> generate_history() {
    
    DateTime ordered_date = DateTime.parse(order.date_created);
    Location order_placed = Location(
      sequence: 1,
        'Order Placed', ordered_date,
        showHour: false, isHere: true, passed: true);

    DateTime processing_date = DateTime.parse(order.date_created);
    Location processing = Location(
      sequence: 2,
        'Processing your order', processing_date,
        showHour: false, isHere: this.isProcessing(), passed: this.isCompleted()); //this.isProcessing(),

  DateTime expectedDeliveryDate = ordered_date.add(Duration(days: 2));
  expectedDeliveryDate = DateTime(
    expectedDeliveryDate.year,
    expectedDeliveryDate.month,
    expectedDeliveryDate.day,
  );

    Location delivered = Location(
      sequence: 3,
      'Delivered',
      expectedDeliveryDate,
      showHour: false,
      isHere: this.isCompleted(),
      passed: this.isCompleted()
    );

   
    this.locations = [order_placed, processing, delivered];
    return this.locations;
  }
  
  isProcessing() {
    return (order.status == "processing" || order.status == "completed");
  }
  isCompleted() {
    return (order.status == "completed");
  }
}

class _TrackingPageState extends State<TrackingPage> {
  String selected_order = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<APIResponse>(
        future: OrderAPIs.getCustomerOrders(widget.user.id.toString()),
        builder: ((context, snapshot) {
          if (snapshot.data != null && snapshot.data?.result.length > 0) {
            List<Order> myOrders = snapshot.data!.result;
            List<String> order_items = [];
            myOrders.forEach((item) {
              DateTime dateTime = DateTime.parse(item.date_created);
              String formattedDate =
                  DateFormat('MMM dd, y - hh:mm a').format(dateTime);
              order_items.add(item.number + " - Date(${formattedDate})");
            });
            OrderHistory? orderHistory = null;
            if (selected_order == "") {
              selected_order = order_items[0];
            }else{
              Order? selected_order_obj = null;
              selected_order_obj =  myOrders.where((element) => element.number == selected_order.split(" ")[0]).first;
              orderHistory = OrderHistory(order: selected_order_obj);
            }
            return Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  image: DecorationImage(
                      image: AssetImage('assets/Group 444.png'),
                      fit: BoxFit.contain)),
              child: Container(
                color: Colors.white54,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      // //brightness: Brightness.light,
                      //TODO:Bug
                      iconTheme: IconThemeData(color: Colors.grey),
                      title: Text(
                        'Track your orders',
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: SizedBox(),
                      actions: <Widget>[CloseButton()],
                    ),
                    body: SafeArea(
                      child: LayoutBuilder(
                        builder: (_, constraints) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  items: order_items.map((val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Container(
                                          color: Colors.white,
                                          child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                val,
                                                maxLines: 2,
                                                semanticsLabel: '...',
                                                overflow: TextOverflow.ellipsis,
                                              ))),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selected_order = newValue as String;
                                    });
                                  },
                                  value: selected_order, //selectedProduct,
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down),
                                  elevation: 0,
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: constraints.maxHeight - 48,
                                ),
                                child: Theme(
                                  data: ThemeData(
                                      primaryColor: PAGE_BACKGROUND_COLOR,
                                      fontFamily: 'Montserrat'),
                                  child: orderHistory == null ? Container() :  Stepper(
//                          physics: NeverScrollableScrollPhysics(),
                                    steps: [
                                      ...orderHistory.generate_history()
                                          .map(
                                            (location) => Step(
                                              isActive: location.isHere ||
                                                  location.passed,
                                              title: Text(location.city),
                                              subtitle:
                                                  Text(location.getDate()),
                                              content: Align(
                                                child: Image.asset(
                                                    'assets/icons/truck.png'),
                                                alignment: Alignment.centerLeft,
                                              ),
                                              state: location.passed
                                                  ? StepState.complete
                                                  : location.isHere
                                                      ? StepState.editing
                                                      : StepState.indexed,
                                            ),
                                          )
                                          .toList()
                                    ],
                                    currentStep: orderHistory.generate_history()
                                            .firstWhere((loc) => loc.isHere).sequence,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            );
          }else{
          return  Container(
              decoration: BoxDecoration(
                  color: Colors.grey[100],
                  image: DecorationImage(
                      image: AssetImage('assets/Group 444.png'),
                      fit: BoxFit.contain)),
              child: Container(
                color: Colors.white54,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      // //brightness: Brightness.light,
                      //TODO:Bug
                      iconTheme: IconThemeData(color: Colors.grey),
                      title: Text(
                        'Track your orders',
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: SizedBox(),
                      actions: <Widget>[CloseButton()],
                    ),
                    body: SafeArea(
                      child: LayoutBuilder(
                        builder: (_, constraints) => Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[ Center(child:  CircularProgressIndicator())]))))
              ));
          }
          
        }));
  }
}

class Location {
  String city;
  DateTime date;
  bool showHour;
  bool isHere;
  bool passed;
  int sequence;

  Location(this.city, this.date,
      {this.showHour = false, this.isHere = false, this.passed = false,
      required this.sequence});

  String getDate() {
    if (showHour) {
      return DateFormat("K:mm aaa, d MMMM y").format(date);
    } else {
      return DateFormat('d MMMM y').format(date);
    }
  }
}
