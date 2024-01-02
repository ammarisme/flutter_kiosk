import 'package:ecommerce_int2/models/product_review.dart';
import 'package:ecommerce_int2/models/product_variation.dart';

part 'product.g.dart';

class Product {
  int id;
  String name;
  String description;
  String price;
  String image;
  String sale_price;
  String regular_price;
  int stock_quantity;
  String weight;
  double rating = 0;

  int in_cart_quantity = 0;
  bool in_wishlist = false;
  List<ProductReview> product_reviews = [];
  double product_overall_rating = 0;
  List<ProductAttribute> attributes;
  String brand_name = "";
  List<dynamic> related_ids;
  List<ProductVariation> variations = [];


  Product(
      {required this.id,
      required this.image,
      required this.name,
      required this.description,
      required this.price,
      required this.sale_price,
      required this.regular_price,
      required this.stock_quantity,
      required this.attributes,
      required this.weight,
      required this.related_ids
      });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  isOnSale(){
    return 
    (this.sale_price!=this.regular_price && this.sale_price != "" && this.regular_price != "")
    || (this.price!=this.regular_price && this.price != "" && this.regular_price != "")
    ;
  }
}

class ProductSearchResult {
  String title;
  String url;
  String image;

  ProductSearchResult(
      {required this.title, required this.url, required this.image});

  factory ProductSearchResult.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchResultFromJson(json);
}

ProductSearchResult _$ProductSearchResultFromJson(Map<String, dynamic> json) {
  return ProductSearchResult(title: json["title"], url: json["url"], image: '');
}


class ProductAttribute{
  int id;
  String name;
  int position;
  bool visible;
  bool variation;
  List<dynamic> options;

   ProductAttribute({
    required this.id, required this.name, required this.position,
    required this.visible,required this.variation,required this.options
    });

  factory ProductAttribute.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeFromJson(json);
}