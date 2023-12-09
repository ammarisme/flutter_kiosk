// Define a ProductNotifier class that extends ChangeNotifier
import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/models/product_review.dart';
import 'package:flutter/cupertino.dart';

import '../api_services/api_service.dart';
import '../models/category.dart';
import '../models/product.dart';


class ProductNotifier extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  List<Product> _recommended_products = [];
  List<Product> get recommended_products => _recommended_products;

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  List<Category> _root_categories = [];
  List<Category> get rootcategories => _root_categories;

  List<Product> _products_of_category = [];
  List<Product> get products_of_category => _products_of_category;

  List<ProductReview> _product_reviews = [];
  List<ProductReview> get product_reviews => _product_reviews;

  late Product _selected_product;



  dynamic selectedCategoryId = -1;

  late Category selectedCategory;

  // Method to update the list of products
  Future<void> updateProducts() async {
    _products = await ProductAPIs.getProducts("608");
    _categories = await ProductAPIs.getCategories();
    _recommended_products = await ProductAPIs.getProducts("609");
    _root_categories = _categories;//.where((category) => category.parent == 0 ||  category.parent == 690).toList();
    selectedCategory = _categories.first;
    notifyListeners();
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
