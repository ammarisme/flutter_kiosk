import 'package:ecommerce_int2/models/cart.dart';

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
      required this.date_completed});

  factory Order.fromJson(Map<String, dynamic> json) {
    
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
    );
  }
}
