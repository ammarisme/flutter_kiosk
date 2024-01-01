import 'package:ecommerce_int2/models/product.dart';

class ProductVariation{
  String sale_price;
  String regular_price;
  String weight;


  ProductVariation({
    required this.weight,
    required this.sale_price,
    required this.regular_price,
    });

factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      _$ProductVariationFromJson(json);

}

ProductVariation _$ProductVariationFromJson(Map<String, dynamic> json) {
  return ProductVariation(weight: json["weight"], sale_price: json["price"], regular_price: json["regular_price"]);
}