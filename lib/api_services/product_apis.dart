import 'dart:convert';

import 'package:fluter_kiosk/models/product_variation.dart';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/product.dart';
import '../models/product_review.dart';
import '../settings.dart';

class Variables {
  static String base_url = 'https://catlitter.lk/wp-json/wc/v3';
}

//API service
class ProductAPIs {
  static String base_url() {
    return 'https://catlitter.lk/wp-json/wc/v3';
  }

  static Future<double> getProductRating(String productId) async {
    var product_reviews = await ProductAPIs.getProductReviews(productId);

    double calculateAverageRating() {
      int totalRatings = product_reviews.fold<int>(
        0,
        (sum, review) => sum + (review.rating),
      );

      int reviewCount = product_reviews.length;
      return reviewCount > 0 ? totalRatings / reviewCount : 0;
    }

    return calculateAverageRating();
  }

  static Future<List<Product>> getProducts(dynamic categoryId) async {
    print('fetching products from updateProducts');
    try {
      final Uri url = Uri.parse(base_url() + '/products?category=$categoryId');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Product> products =
            data.map((item) => Product.fromJson(item)).toList();
        print(products);
        return products;
      } else {
        print('Failed to load products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<List<ProductReview>> getProductReviews(String productId) async {
    print('fetching product reviews........');
    try {
      final Uri url =
          Uri.parse(base_url() + '/products/reviews?product=' + productId);

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print('---debug');

        List<ProductReview> product_reviews =
            data.map((item) => ProductReview.fromJson(item)).toList();
        return product_reviews;
      } else {
        print('Failed to load products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<List<ProductVariation>> getProductVariations(
      String productId) async {
    print('fetching product variations........');
    try {
      final Uri url =
          Uri.parse(base_url() + '/products/' + productId + "/variations");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print('---debug');

        List<ProductVariation> product_reviews =
            data.map((item) => ProductVariation.fromJson(item)).toList();
        return product_reviews;
      } else {
        print('Failed to load product variations: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<List<Category>> getCategories() async {
    print('fetching categories........');
    try {
      final Uri url =
          Uri.parse(base_url() + '/products/categories?per_page=100');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        List<Category> categories =
            data.map((item) => Category.fromJson(item)).toList();
        return categories;
      } else {
        print('Failed to load categories: ${response.statusCode}');
        print(response.body);
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<Product?> getProduct(String productid) async {
    print('fetching product........');
    try {
      final Uri url = Uri.parse(base_url() + '/products/${productid}');
      print(url);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        dynamic data = json.decode(response.body);
        Product product = Product.fromJson(data);
        return product;
      } else {
        throw Exception("no product found for ${productid}");
      }
    } catch (e, stackTrace) {
      print('Error fetching products: $e');
      print('StackTrace: $stackTrace');
      return null;
    }
  }

  static Future<List<Product>> searchProducts(String search_text) async {
    print('fetching products........');
    try {
      final Uri url = Uri.parse(
          'https://catlitter.lk/wp-json/wc/v3/products?per_page=100&search=${search_text}');
      print(url);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic " + Settings.TOKEN
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Product> products =
            data.map((item) => Product.fromJson(item)).toList();
        return products;
      } else {
        print('Failed to load products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }
}
