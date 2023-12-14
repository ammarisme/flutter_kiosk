import 'package:ecommerce_int2/models/product_review.dart';

part 'product.g.dart';

class Product {
  int id;
  String name;
  String description;
  String price;
  String image;
  String sale_price;
  String regular_price;
  int stock_quantity;

  int in_cart_quantity = 0;
  bool in_wishlist = false;
  List<ProductReview> product_reviews = [];
  double product_overall_rating = 0;

  Product(
      {required this.id,
      required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.sale_price,
      required this.regular_price,
      required this.stock_quantity});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

class ProductSearchResult {
  String title;
  String url;
  String image;

  ProductSearchResult(
      {required this.title, required this.url, required this.image});

  factory ProductSearchResult.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchResultFromJson(json);
}

ProductSearchResult _$ProductSearchResultFromJson(Map<String, dynamic> json) {
  return ProductSearchResult(title: json["title"], url: json["url"], image: '');
}
