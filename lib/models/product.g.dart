// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    image : json['image'] as String,
    name: json['name'] as String,
    description : json['description'],
    price: json['price'] as double,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };
