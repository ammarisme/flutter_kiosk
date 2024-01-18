import 'package:ecommerce_int2/models/product.dart';

class ProductVariation{
  int id;
  String sale_price;
  String regular_price;
  String weight;
  int stock_quantity;


  ProductVariation({
    required this.id,
    required this.weight,
    required this.sale_price,
    required this.regular_price,
    required this.stock_quantity
    });

factory ProductVariation.fromJson(Map<String, dynamic> json) =>
      _$ProductVariationFromJson(json);

}

ProductVariation _$ProductVariationFromJson(Map<String, dynamic> json) {
  return ProductVariation(id : json["id"],weight: json["weight"], sale_price: json["price"], regular_price: json["regular_price"], stock_quantity: json["stock_quantity"]);
}