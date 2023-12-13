import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/product.dart';
import '../models/product_review.dart';
import '../models/user.dart';

class Variables {
  static String base_url = 'https://catlitter.lk/wp-json/wc/v3';
}

//API service
class ProductAPIs {
  static String base_url() {
    return 'https://catlitter.lk/wp-json/wc/v3';
  }

  static Future<List<Product>> getProducts(dynamic categoryId) async {
    print('fetching products........');
    try {
      final Uri url = Uri.parse(base_url() + '/products?category=$categoryId');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy"
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

  static Future<List<ProductReview>> getProductReviews(String productId) async {
    print('fetching product reviews........');
    try {
      final Uri url = Uri.parse(base_url() + '/products/reviews?product=' + productId);

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
              "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy"
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

  static Future<List<Category>> getCategories() async {
    print('fetching categories........');
    try {
      final Uri url = Uri.parse(base_url() + '/products/categories');

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy"
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print('---debug');

        List<Category> categories =
        data.map((item) => Category.fromJson(item)).toList();
        return categories;
      } else {
        print('Failed to load products: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  static Future<Product?> getProduct(int productid) async {
    print('fetching product........');
    try {
      final Uri url = Uri.parse(base_url() + '/products/${productid}');
      print(url);
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization":
          "Basic Y2tfYTU0NTViYmE1NDhiYThkM2I0MzM1ZjY1MWIxNDgyYTJiYzU5YWQ3Yzpjc19kMjA5OGE5YWY1ZGZmMmFjNjg3ODcxMWM3ZWY2YTQ4YWZkNDAyOTIy"
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


}
