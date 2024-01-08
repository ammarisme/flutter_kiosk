// Define a ProductNotifier class that extends ChangeNotifier
import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/cart.dart';

//This class acts as the notifier to all api calls we do for the main page.
class CartNotifier extends ChangeNotifier {
  late Cart? cart = null;

  //line items and discounts
  double totalLineDiscounts = 0;
  double totalBeforeDiscounts = 0;
  double discountOnTotal = 0;
  double total = 0;

  //payment related
  late String payment_method_title = "";
  int selected_payment_method = 0;
  late String payment_method = "";
  Map<String, double> payment_method_discounts = {
    'cash': 3,
    'card': 0,
    'card_on_delivery': 0,
    'bt': 0,
  };
  double payment_method_discount_amount = 0;
  double payment_method_discount_percentage = 0;
  bool paid = false;

  //shipping related
  late Address? billing_address = null;
  late Address? shipping_address = null;
  Map<String, double> shipping_charges_directory = {
    'dd': 200,
    'sp': 100
  };
  double shipping_charges = 0;
  String shipping_method_id = "";
  String shipping_method_title = "";

  //Calculates all order related numbers
  void calculateOrderInfo() {
    this.totalLineDiscounts = 0;
    this.totalBeforeDiscounts = 0;

    // Calculate total line discounts and total before discounts
    print("calculating line items: "+this.cart!.line_items.length.toString());
    for (var item in cart!.line_items) {
      double lineTotal = item.quantity * item.salePrice;
      print(item.quantity);
      totalBeforeDiscounts += lineTotal;

      double discountAmount = (item.linediscount / 100) * lineTotal;
      totalLineDiscounts += discountAmount;
    }

    this.discountOnTotal = (totalBeforeDiscounts - totalLineDiscounts) *
        (payment_method_discount_percentage / 100);

    this.total = (totalBeforeDiscounts - totalLineDiscounts) - discountOnTotal;
  }

  Future<Cart?> getCart() async {
    print("cart fetched");
    CartAPIs cartAPIs = CartAPIs();
    return cartAPIs.getCart();
  }

  Future<void> addItem(product_id, quantity) async {
    CartAPIs cartAPIs = CartAPIs();
    readCartNonce().then((nonce) {
        cartAPIs.addItem(product_id, quantity, nonce);
        notifyListeners();
    });
  }

  Future<String?> readCartNonce() async {
      final storage = FlutterSecureStorage();
      return await storage.read(key: 'cart_nonce');
  }

  

  addOrUpdateAddress1(String address1) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
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
    } else {
      this.cart?.shipping.address1 = address1;
    }
  }

  void addOrUpdateAddress2(String address2) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
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
    } else {
      this.cart?.shipping.address2 = address2;
    }
  }

  void addOrUpdateFirstName(String value) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: value,
          lastName: "",
          company: "",
          address1: "",
          address2: "",
          city: "",
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.firstName = value;
    }
  }

  void addOrUpdateLastName(String value) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
          lastName: value,
          company: "",
          address1: "",
          address2: "",
          city: "",
          state: "",
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.lastName = value;
    }
  }

  void addOrUpdateCity(String city) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
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
    } else {
      this.cart?.shipping.city = city;
    }
  }

  void addOrUpdateStateOrProvince(String value) {
    if (this.cart?.shipping == null) {
      this.cart?.shipping = Address(
          firstName: "",
          lastName: "",
          company: "",
          address1: "",
          address2: "",
          city: "",
          state: value,
          postcode: "",
          country: "",
          email: "",
          phone: "");
    } else {
      this.cart?.shipping.state = value;
    }
  }

  Future<bool> createOrder() async {
    CartAPIs cartAPIs = CartAPIs();
    bool created = await cartAPIs.createOrder(this.cart);
    return created;
  }

  void updatePayentMethod(payment_method, payment_method_title) {
    this.payment_method = payment_method;
    this.payment_method_title = payment_method_title;
    this.payment_method_discount_percentage =
        this.payment_method_discounts[payment_method]!;

    this.calculateOrderInfo();
    notifyListeners();
  }

  void updateShippingMethod(shipping_method) {
    this.shipping_charges = this.shipping_charges_directory[shipping_method]!;

    this.calculateOrderInfo();

    notifyListeners();
  }

  void copyShippingInfoToBilling() {
    cart?.billing = Address(
        firstName: cart!.shipping.firstName,
        lastName: cart!.shipping.lastName,
        company: "",
        address1: cart!.shipping.address1,
        address2: cart!.shipping.address2,
        city: cart!.shipping.city,
        state: cart!.shipping.state,
        postcode: cart!.shipping.postcode,
        country: cart!.shipping.country,
        email: "",
        phone: "");
  }

  void loadProduct(Cart _cart) {
    this.cart = _cart;
  }

  void updateLineItemQuantity(int id,int quantity) {
    int? index = this.cart?.line_items.indexWhere((cart_item) => cart_item.product_id == id);
    this.cart?.line_items[index as int].quantity = quantity;
  }
}
