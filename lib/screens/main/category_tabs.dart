
import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/models/category.dart';
import 'package:flutter/material.dart';
import 'components/tab_view.dart';

class CategoryTabs extends StatefulWidget {

  CategoryTabs();

  @override
  _CategoryTabsState createState() => _CategoryTabsState();
}


class _CategoryTabsState extends State<CategoryTabs>  with TickerProviderStateMixin<CategoryTabs>{
 List<Tab> category_tabs = [];
 List<Category> category_tree = [];
TabController? tabController;

@override
void initState() {
  super.initState();
  
  // Make API call here
   ProductAPIs.getCategories().then((categories) {
    setState(() {
          category_tree = buildCategoryTree(categories, 0);
          category_tabs = category_tree.map((category) => Tab(text: category.name)).toList();
          this.tabController = TabController(length: category_tabs.length, vsync: this);
    });
   }
    );
}

@override
Widget build(BuildContext context) {

    if (category_tabs.isEmpty){
      return Container();
    }

    Widget tabBar = TabBar(
      tabs: category_tabs,
      labelStyle: TextStyle(fontSize: 16.0),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: this.tabController,
    );

    Widget tabView = TabView(
                    categories: category_tree,
                    products_of_category: [],
                    tabController: this.tabController as TabController,
                  );

  return Container(
    child:Column(
      children: [tabBar,
      tabView]));
}

List<Category> buildCategoryTree(List<Category> categories, dynamic parentId) {
  List<Category> categoryTree = [];

  for (var category in categories) {
    if (category.parent == parentId) {
      category.sub_categories = buildCategoryTree(categories, category.id);
      categoryTree.add(category);
    }
  }

  return categoryTree;
}
}



// class W extends StatefulWidget {
//   Attrib attrib;

//   W({required this.attrib});

//   @override
//   _WState createState() => _WState();
// }


// class _WState extends State<W> {

// @override
// void initState() {
//   super.initState();
//   // Make API call here
// }
// }

