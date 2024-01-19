import 'package:ecommerce_int2/models/category.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/main/components/product_grid.dart';
import 'package:flutter/material.dart';

class TabView extends StatelessWidget {
  List<Product> recommeded_products = [];
  List<Product> products_of_category = [];
  List<Category> categories = [];

  final TabController tabController;

  TabView(
      {
      required this.tabController,
      required this.products_of_category,
      required this.categories
      });

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height:2000,
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: categories.map((category) {
          // Generate a Container for each product in the list
          print("rendering "+ category.name);
          return
          Column(children: <Widget>[
            Flexible(
                child: ProductGrid(
                    category: category,
                    products: products_of_category)),
          ]);
        }).toList() 
        
        ));
  }
}


// import 'package:ecommerce_int2/models/category.dart';
// import 'package:ecommerce_int2/models/product.dart';
// import 'package:ecommerce_int2/screens/main/components/product_grid.dart';
// import 'package:flutter/material.dart';
// import 'category_card.dart';


// class TabView extends StatelessWidget {
//   List<Product> recommeded_products = [];
//   List<Product> products_of_category = [];
//   Category selectedCategory;

//   final TabController tabController;

//   TabView(
//       {
//       required this.tabController,
//       required this.products_of_category,
//       required this.selectedCategory});

//   @override
//   Widget build(BuildContext context) {
//     return 
//     Container(
//       height:100,
//       child: TabBarView(
//         physics: NeverScrollableScrollPhysics(),
//         controller: tabController,
//         children: <Widget>[
// Container(child:Text("TEXT1")),Container(child:Text("TEXT2")),Container(),Container(),Container(),Container(),Container(),Container(),Container(),
//           // Column(children: <Widget>[
//           //   SizedBox(
//           //     height: 16.0,
//           //   ),
//           //   Flexible(
//           //       child:
//           //       ProductGrid(
//           //           product_grid_title: "Recommended",
//           //           products: this.recommeded_products))
//           //       // RecommendedList(
//           //       //     recommeded_products: this.recommeded_products))
//           // ]),
//           // Container(
//           //   child: Column(
//           //     mainAxisSize: MainAxisSize.min,
//           //     children: <Widget>[
//           //       Container(
//           //           margin: EdgeInsets.all(8.0),
//           //           height: MediaQuery.of(context).size.height / 9,
//           //           width: MediaQuery.of(context).size.width,
//           //           child: ListView.builder(
//           //               scrollDirection: Axis.horizontal,
//           //               itemCount: root_categories.length,
//           //               itemBuilder: (_, index) => CategoryCard(
//           //                     selectedCategory: selectedCategory,
//           //                     category: root_categories[index],
//           //                   ))),
//           //       SizedBox(
//           //         height: 16.0,
//           //       ),
//           //       Flexible(
//           //           child: ProductGrid(
//           //               product_grid_title: this.selectedCategory.name,
//           //               products: this.products_of_category)),
//           //     ],
//           //   ),
//           // ),
//           Column(children: <Widget>[
//             SizedBox(
//               height: 16.0,
//             ),
//             Flexible(
//                 child: ProductGrid(
//                     product_grid_title: this.selectedCategory.name,
//                     products: this.products_of_category)),
//           ]),
//           // Column(children: <Widget>[
//           //   SizedBox(
//           //     height: 16.0,
//           //   ),
//           //   Flexible(
//           //       child: ProductGrid(
//           //           product_grid_title: this.selectedCategory.name,
//           //           products: this.products_of_category)),
//           // ]),
//           // Column(children: <Widget>[
//           //   SizedBox(
//           //     height: 16.0,
//           //   ),
//           //   Flexible(
//           //       child: ProductGrid(
//           //           product_grid_title: this.selectedCategory.name,
//           //           products: this.products_of_category)),
//           // ]),
//         ]));
    
//   }
// }
