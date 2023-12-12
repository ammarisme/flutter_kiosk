// Define a ProductNotifier class that extends ChangeNotifier
import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/models/product_review.dart';
import 'package:ecommerce_int2/models/user.dart';
import 'package:flutter/cupertino.dart';

import '../api_services/api_service.dart';
import '../models/cart.dart';
import '../models/category.dart';
import '../models/product.dart';


//This class acts as the notifier to all api calls we do for the main page.
class CartNotifier extends ChangeNotifier {
  late Cart? cart = null;
  late Address? billing_address = null;
  late Address? shipping_address = null;
  late String payment_method = "";
  late String payment_method_title= "";

  Map<String, dynamic> order_info = {};

  void calculateOrderInfo(Cart? cart) {
    double totalLineDiscounts = 0;
    double totalBeforeDiscounts = 0;

    // Calculate total line discounts and total before discounts
    for (var item in cart!.items) {
      double lineTotal = item.quantity * item.salePrice;
      totalBeforeDiscounts += lineTotal;

      double discountAmount = (item.linediscount / 100) * lineTotal;
      totalLineDiscounts += discountAmount;
    }

    double discountOnTotal = (totalBeforeDiscounts - totalLineDiscounts) * (cart!.payment_method_discount/ 100);
    double total = (totalBeforeDiscounts - totalLineDiscounts) - discountOnTotal + cart!.shipping_charges;

    this.order_info = {
      'total_line_discounts': totalLineDiscounts,
      'total_before_discounts': totalBeforeDiscounts,
      'discount_on_total': discountOnTotal,
      'shipping': cart.shipping_charges,
      'total': total,
    };
  }

  void loadProduct(Cart _cart) {
    this.cart = _cart;
  }

  Future<void> getCart() async {
    print("cart fetched");
    CartAPIs cartAPIs = CartAPIs();
    this.cart = await cartAPIs.getCart();
    
    notifyListeners();
  }

  Future<void> addItem(product_id, quantity, nonce) async {
    print("adding item to cart");
    CartAPIs cartAPIs = CartAPIs();
    bool added = await cartAPIs.addItem(16652, 1, nonce);
    notifyListeners();
  }

  addOrUpdateAddress1(String address1) {
    if (this.cart?.billingAddress == null) {
      this.cart?.billingAddress = Address(firstName: "",
          lastName: "",
          company: "",
          address1: address1,
          address2: "",
          city: "",
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    }
    else {
      this.cart?.billingAddress.address1 = address1;
    }
  }

  void addOrUpdateAddress2(String address2) {
    if (this.cart?.billingAddress == null) {
      this.cart?.billingAddress = Address(firstName: "",
          lastName: "",
          company: "",
          address1: "",
          address2: address2,
          city: "",
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    }
    else {
      this.cart?.billingAddress.address2 = address2;
    }

    void addOrUpdateCity(String city) {
      if (this.cart?.billingAddress == null) {
        this.cart?.billingAddress = Address(firstName: "",
            lastName: "",
            company: "",
            address1: "",
            address2: "",
            city: city,
            state: "",
            postcode: "",
            country: "",
            email: "",
            phone: "");
      }
      else {
        this.cart?.billingAddress.city = city;
      }
    }

    Future<void> createOrder() async {

    }
  }

  void updatePayentMethod(payment_method, payment_method_title) {
    this.payment_method = payment_method;
    this.payment_method_title = payment_method_title;
  }
}
