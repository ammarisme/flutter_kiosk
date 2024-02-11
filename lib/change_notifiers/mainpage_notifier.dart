// Define a ProductNotifier class that extends ChangeNotifier
import 'package:fluter_kiosk/api_services/cart_apis.dart';
import 'package:fluter_kiosk/api_services/product_apis.dart';
import 'package:fluter_kiosk/models/product_review.dart';
import 'package:flutter/cupertino.dart';

import '../models/category.dart';
import '../models/product.dart';


//This class acts as the notifier to all api calls we do for the main page.
class MainPageNotifier extends ChangeNotifier {
  List<Product> _products = []; //top bar products
  List<Product> get products => _products;

  List<Product> _recommended_products = []; // recommended products
  List<Product> get recommended_products => _recommended_products;

  List<Category> _categories = []; // categories to be listed
  List<Category> get categories => _categories;

  List<Product> _products_of_category = [];
  List<Product> get products_of_category => _products_of_category;

  List<ProductReview> _product_reviews = [];
  List<ProductReview> get product_reviews => _product_reviews;



  dynamic selectedCategoryId = -1;

  Category selectedCategory = Category(name: '', image: '', id: 1, parent: 1);

  // Method to update the list of products
  Future<bool> updateProducts() {
    ProductAPIs.getProducts("608").then((value) {
      _products = value;
      notifyListeners();
    });
    ProductAPIs.getCategories().then((value) {
      _categories = value;
      selectedCategory = _categories.first;
      notifyListeners();
    });;
    ProductAPIs.getProducts("609").then((value) {
      _recommended_products = value;
      notifyListeners();
    });;
    CartAPIs.getCart().then((value) {
      notifyListeners();
    });;
    ;
    return Future(() => true);
  }

  Future<void> selectCategory(dynamic categoryId) async{
    _products_of_category = await ProductAPIs.getProducts(categoryId);
    this.selectedCategoryId = categoryId;
    this.selectedCategory = _categories.where((category) => category.id == categoryId).first;
    notifyListeners();
  }

  Future<void> getProductReviews(String productId) async{
    _product_reviews = await ProductAPIs.getProductReviews(productId);
    notifyListeners();
  }


}
