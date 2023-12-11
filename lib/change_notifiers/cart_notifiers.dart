// Define a ProductNotifier class that extends ChangeNotifier
import 'package:ecommerce_int2/api_services/cart_apis.dart';
import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/models/product_review.dart';
import 'package:flutter/cupertino.dart';

import '../api_services/api_service.dart';
import '../models/cart.dart';
import '../models/category.dart';
import '../models/product.dart';


//This class acts as the notifier to all api calls we do for the main page.
class CartNotifier extends ChangeNotifier {
  late Cart? cart= null;

  void loadProduct(Cart _cart){
    this.cart = _cart;
  }

  Future<void> getCart() async{
    print("cart fetched");
    CartAPIs cartAPIs = CartAPIs();
    this.cart  = await cartAPIs.getCart();
    notifyListeners();
  }

  Future<void> addItem(product_id, quantity, nonce) async{
    print("adding item to cart");
    CartAPIs cartAPIs = CartAPIs();
    bool added = await cartAPIs.addItem(16652, 1, nonce);
    notifyListeners();
  }



}
