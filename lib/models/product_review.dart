import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/rendering.dart';

part 'product_review.g.dart';

class ProductReview {
  int id;
  String date_created;
  int product_id;
  String product_name;
  String reviewer;
  String review;
  int rating;
  bool verified;
  String? reviewer_avatar_urls;

  ProductReview({
    required this.id,
    required this.date_created,
    required this.product_id,
    required this.product_name,
    required this.reviewer,
    required this.review,
    required this.rating,
    required this.verified,
    required this.reviewer_avatar_urls
  });

  factory ProductReview.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewToJson(this);
}
