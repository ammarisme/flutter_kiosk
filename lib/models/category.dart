import 'dart:ui';

part 'category.g.dart';

class Category {
  // Color begin;
  // Color end;
  String name;
  String image;
  dynamic parent;
  dynamic id;
  Color begin = Color(0xffFCE183);
  Color end = Color(0xffF68D7F);

  Category({
    required this.name,
    required this.image,
    required this.id,
    required this.parent
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
