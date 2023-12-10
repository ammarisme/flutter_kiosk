import 'package:ecommerce_int2/models/product_review.dart';

part 'product.g.dart';

class Product {
  String name;
  String description;
  String price;
  String image;
  String sale_price;
  String regular_price;

  int in_cart_quantity = 0;
  bool in_wishlist = false;
  List<ProductReview> product_reviews = [];
  double product_overall_rating = 0;


  Product({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.sale_price,
    required this.regular_price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
