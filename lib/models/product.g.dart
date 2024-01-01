// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  final sale_price = json['sale_price'] != null ? json['sale_price'] : "";
  final regular_price =
      json['regular_price'] != null ? json['regular_price'] : "";
  final primary_image_url =
      (json['images'] != null && json['images'].length > 0)
          ? json['images'][0]["src"]
          : "";

List<ProductAttribute> getProductAttributes(attributes){
  List<ProductAttribute> my_attributes   = [];
        attributes.forEach((attribute) => {
          my_attributes.add(ProductAttribute.fromJson(attribute))
        });
        return my_attributes;
      }

  return Product(
      id: json["id"],
      name: json['name'] as String,
      description: json['description'],
      price: json['price'] as String,
      image: primary_image_url as String,
      sale_price: sale_price,
      //json['sale_price'] as String,
      regular_price: regular_price,
      weight: json["weight"],

      //json['regular_price'] as String
      stock_quantity: json['stock_quantity'] ?? 0,
      attributes: getProductAttributes(json["attributes"]),
      related_ids : json['related_ids']
      );

      
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };



ProductAttribute _$ProductAttributeFromJson(Map<String, dynamic> json) {
  
  return ProductAttribute(
    id: json["id"],
    name: json["name"],
    position: json["position"],
    visible: json["visible"],
    variation: json["variation"],
    options: json["options"]);
}
