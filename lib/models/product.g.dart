// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Product _$ProductFromJson(Map<String, dynamic> json) {
  final sale_price = json['sale_price'] != null ? json['sale_price'] : "";
  final regular_price = json['regular_price'] != null ? json['regular_price'] : "";

  return Product(
    name: json['name'] as String,
    description : json['description'],
    price: json['price'] as String,
    image: json['images'][0]["src"] as String,
    sale_price: sale_price,//json['sale_price'] as String,
    regular_price: regular_price,//json['regular_price'] as String
    stock_quantity:json['stock_quantity']??0
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };
