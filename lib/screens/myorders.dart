import 'package:fluter_kiosk/api_services/order_apis.dart';
import 'package:fluter_kiosk/common/utils.dart';
import 'package:fluter_kiosk/models/order.dart';
import 'package:fluter_kiosk/models/user.dart';
import 'package:flutter/material.dart';

class MyOrdersPage extends StatefulWidget {
  final User loggedInUser;

  MyOrdersPage({required this.loggedInUser});

  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
MyOrdersVM viewModel = MyOrdersVM();

  @override
  void initState() {
    super.initState();

    viewModel.orders = [];
    OrderAPIs.getCustomerOrders(widget.loggedInUser.id.toString()).then((value)  {
      setState(() {
        viewModel.orders = value.result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("My Orders"),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
        ],
      ),
      body: SafeArea(
        top: true,
        child: OrderList(orders: viewModel.orders),
      ),
    );
  }
}

class MyOrdersVM{
  List<Order> orders = [];
}

class OrderList extends StatefulWidget {
  final List<Order> orders;
  OrderList({required this.orders});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  // Dummy data for orders

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.orders.length,
      itemBuilder: (context, index) {
        return OrderTile(order: widget.orders[index]);
      },
    );
  }
}

class OrderTile extends StatelessWidget {
  final Order order;

  OrderTile({required this.order});

  @override
  Widget build(BuildContext context) {
     final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      backgroundColor: Colors.blue,
    );

    return ExpansionTile(
      title: Text('Order Id :  ${order.id} / Date : ${Utils.makeDateStringHumanReadable(order.date_created)}'),
      children: [
        // Add your line items here
        for (OrderLineItem item in order.line_items) ListTile(
          title: Row(
            children: [
              // Display the image if available
              if (item.image_url != "")
                //Line image
                Container(width: 60,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.network(
                    item.image_url!,
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    fit: BoxFit.cover,
                  ),
                )
                ),
                //Line name
                Container(width: 200,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(item.name),
                ),),
                 Container(width: 200,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text("Qty : ${item.quantity}"),
                )),

                //The reorder button container
                Container(width: 200,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: TextButton(
      style: flatButtonStyle,
      onPressed: () {
        print('Button pressed');
      },
      child: Text('Reorder'),
    )

                ))
              // Display the name or other text
            ],
          ),
          ),
      ],
    );
  }
}


