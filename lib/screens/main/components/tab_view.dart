import 'package:ecommerce_int2/models/category.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/main/components/product_grid.dart';
import 'package:flutter/material.dart';
import 'category_card.dart';

class TabView extends StatelessWidget {
  List<Category> categories = [];
  List<Product> recommeded_products = [];
  List<Product> products_of_category = [];
  List<Category> root_categories = [];
  Category selectedCategory;

  final TabController tabController;

  TabView(
      {required this.categories,
      required this.tabController,
      required this.recommeded_products,
      required this.products_of_category,
      required this.root_categories,
      required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(
                child:
                ProductGrid(
                    product_grid_title: "Recommended",
                    products: this.recommeded_products))
                // RecommendedList(
                //     recommeded_products: this.recommeded_products))
          ]),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: root_categories.length,
                        itemBuilder: (_, index) => CategoryCard(
                              selectedCategory: selectedCategory,
                              category: root_categories[index],
                            ))),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(
                    child: ProductGrid(
                        product_grid_title: this.selectedCategory.name,
                        products: this.products_of_category)),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(
                child: ProductGrid(
                    product_grid_title: this.selectedCategory.name,
                    products: this.products_of_category)),
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(
                child: ProductGrid(
                    product_grid_title: this.selectedCategory.name,
                    products: this.products_of_category)),
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(
                child: ProductGrid(
                    product_grid_title: this.selectedCategory.name,
                    products: this.products_of_category)),
          ]),
        ]);
  }
}
