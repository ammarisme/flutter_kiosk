// Define a ProductNotifier class that extends ChangeNotifier
import 'package:fluter_kiosk/api_services/product_apis.dart';
import 'package:flutter/cupertino.dart';

import '../models/product.dart';

//This class acts as the notifier to all api calls we do for the main page.
class ProductNotifier extends ChangeNotifier {
  late Product selected_product;

  void loadProduct(Product _product) {
    this.selected_product = _product;
  }

  Future<void> getProductReviewsNotifier(
      Product product, String productId) async {
    this.selected_product = product;
    this.selected_product.product_reviews =
        await ProductAPIs.getProductReviews(productId);
    print('test-----------------------------');

    double calculateAverageRating() {
      int totalRatings = this.selected_product.product_reviews.fold<int>(
            0,
            (sum, review) => sum + (review.rating),
          );

      int reviewCount = this.selected_product.product_reviews.length;
      return reviewCount > 0 ? totalRatings / reviewCount : 0;
    }

    this.selected_product.product_overall_rating = calculateAverageRating();
    print(this.selected_product.product_overall_rating);
    notifyListeners();
  }

  Future<Product?> getProduct(int id) async {
    return ProductAPIs.getProduct(id.toString());
  }

  Future<List<Product>> searchProducts(String value) {
    return ProductAPIs.searchProducts(value);
  }
}
