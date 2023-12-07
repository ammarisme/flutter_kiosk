// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  String? imageUrl = json['image']?['src'] as String?;
  return Category(
    name: json['name'] as String,
    image: imageUrl ?? ''
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
      'image': instance.image,
    };
