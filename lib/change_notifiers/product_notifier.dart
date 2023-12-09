// Define a ProductNotifier class that extends ChangeNotifier
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

  dynamic selectedCategoryId = -1;

  late Category selectedCategory;

  // Method to update the list of products
  Future<void> updateProducts() async {
    ApiService apiService = ApiService();
    _products = await ApiService.getProducts("608");
    _categories = await ApiService.getCategories();
    _recommended_products = await ApiService.getProducts("609");
    _root_categories = _categories;//.where((category) => category.parent == 0 ||  category.parent == 690).toList();
    selectedCategory = _categories.first;
    notifyListeners();
  }

  Future<void> selectCategory(dynamic categoryId) async{
    _products_of_category = await ApiService.getProducts(categoryId);
    this.selectedCategoryId = categoryId;
    this.selectedCategory = _categories.where((category) => category.id == categoryId).first;

    notifyListeners();
  }
}
