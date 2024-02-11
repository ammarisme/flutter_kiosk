import 'package:fluter_kiosk/models/cart.dart';
import 'package:flutter_wp_woocommerce/models/order.dart';

class Order {
  int id;
  int parent_id;
  String number;
  String order_key;
  String status;
  String currency;
  String date_created;
  String date_modified;
  String discount_total;
  String shipping_total;
  String total;
  String total_tax;
  int customer_id;
  ShippingInfo shipping;
  String payment_method_title;
  String date_completed;
  List<OrderLineItem> line_items;
  Order(
      {required this.id,
      required this.parent_id,
      required this.number,
      required this.order_key,
      required this.status,
      required this.currency,
      required this.date_created,
      required this.date_modified,
      required this.discount_total,
      required this.shipping_total,
      required this.total,
      required this.total_tax,
      required this.customer_id,
      required this.shipping,
      required this.payment_method_title,
      required this.date_completed,
      required this.line_items});

  factory Order.fromJson(Map<String, dynamic> json) {
    List<OrderLineItem> my_line_items = json['line_items'] !=null? (json['line_items'] as List<dynamic>)
        .map((item) => OrderLineItem.fromJson(item))
        .toList() : [];

    return Order(
      id: json['id'],
      parent_id: json['parent_id'],
      number: json['number'],
      order_key: json['order_key'],
      status: json['status'],
      currency: json['currency'],
      date_created: json['date_created'],
      date_modified: json['date_modified'],
      discount_total: json['discount_total'],
      shipping_total: json['shipping_total'],
      total: json['total'],
      total_tax: json['total_tax'],
      customer_id: json['customer_id'],
      shipping: ShippingInfo(),
      payment_method_title: json['payment_method_title'],
      date_completed: "",//json['date_completed'],
      line_items : my_line_items
    );
  }
}



class OrderLineItem {
  int id;
  String name;
  int product_id;
  int variation_id;
  int quantity;
  double subtotal;
  double price;
  String image_url;
  OrderLineItem(
      {required this.id,
      required this.name,
      required this.product_id,
      required this.variation_id,
      required this.quantity,
      required this.subtotal,
      required this.price,
      required this.image_url
     });

  factory OrderLineItem.fromJson(Map<String, dynamic> json) {
    double price ;
    if (json["price"] is int){
      price = json["price"].toDouble();
    }else{
      price = json["price"];
    }
    return OrderLineItem(
      id: json['id'],
      name: json['name'],
      product_id: json['product_id'],
      variation_id: json['variation_id'],
      quantity: json['quantity'],
      subtotal: double.parse(json['subtotal']),
      price: price,
      image_url: json["image"]!= null ? json["image"]["src"] : ""
    );
  }
}
