import 'package:ecommerce_int2/models/category.dart';
import 'package:flutter/material.dart';
import 'category_card.dart';
import 'recommended_list.dart';

class TabView extends StatelessWidget {
  List<Category> categories = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Cats',
      'assets/fish.png',
    ),
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Dogs',
      'assets/fish.png',
    ),
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Fish',
      'assets/fish.png',
    ),
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Birds',
      'assets/fish.png',
    ),
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Hamster',
      'assets/fish.png',
    ),
  ];

  final TabController tabController;

  TabView({
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height / 9);
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
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
                        itemCount: categories.length,
                        itemBuilder: (_, index) => CategoryCard(
                              category: categories[index],
                            ))),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(child: RecommendedList()),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList())
          ]),
        ]);
  }
}
