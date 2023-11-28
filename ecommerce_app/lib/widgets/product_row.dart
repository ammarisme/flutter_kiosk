
import 'package:ecommerce_app/widgets/product_thumbnail.dart';
import 'package:flutter/cupertino.dart';

class ProductRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230, // Fixed height
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ProductThumbnailWidget(),
          ProductThumbnailWidget(),
          ProductThumbnailWidget(),
        ],
      ),
    );
  }
}
