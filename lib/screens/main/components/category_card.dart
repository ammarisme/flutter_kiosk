import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/models/category.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../change_notifiers/mainpage_notifier.dart';
import '../main_page.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final Category? selectedCategory;
  final Function(List<Product> products) selectCategoryFunc;

  const CategoryCard({required this.category, required this.selectedCategory, required this.selectCategoryFunc});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 80,
                width: 90,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Container(
                  height: 80,
                  width: 90,
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          colors: [
                        Colors.white,
                        selectedCategory?.id != category.id
                            ? Colors.grey.shade100
                            : Colors.blue
                      ],
                          //TODO: [category.begin, category.end],
                          center: Alignment(0, 0),
                          radius: 0.8,
                          focal: Alignment(0, 0),
                          focalRadius: 0.1)),
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Center(
                      child: category.image!= ""?
                      FadeInImage(
                        placeholder: AssetImage('assets/icons/logo_small.png'), // Placeholder image asset
                        image: NetworkImage(category.image), // Network image URL
                        fit: BoxFit.cover,
                      )
                      : Image.asset('assets/icons/logo_small.png')
                    ),
                    onTap: () {
                    ProductAPIs.getProducts(category.id).then((products) {
                                                    this.selectCategoryFunc(products);
                            });
                      //mainPageNotifier.selectCategory(category.id);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
