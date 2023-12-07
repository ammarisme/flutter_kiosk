import 'dart:ui';

part 'category.g.dart';

class Category {
  // Color begin;
  // Color end;
  String name;
  String image;
  Color begin = Color(0xffFCE183);
  Color end = Color(0xffF68D7F);

  Category({required this.name, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
