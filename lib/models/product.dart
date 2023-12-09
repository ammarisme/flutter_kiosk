part 'product.g.dart';

class Product {
  String name;
  String description;
  String price;
  String image;
  String sale_price;
  String regular_price;

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
