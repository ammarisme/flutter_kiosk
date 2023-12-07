// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************


Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    name: json['name'] as String,
    description : json['description'],
    price: json['price'] as String,
    image: json['images'][0]["src"] as String
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };
