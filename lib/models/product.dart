part 'product.g.dart';

class Product {
  String name;
  String description;
  String price;
  String image;

  Product({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
