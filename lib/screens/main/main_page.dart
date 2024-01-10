
import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/cart_notifiers.dart';
import 'package:ecommerce_int2/change_notifiers/product_notifier.dart';
import 'package:ecommerce_int2/change_notifiers/user_notifier.dart';
import 'package:ecommerce_int2/custom_background.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/auth/login_page.dart';
import 'package:ecommerce_int2/screens/category/category_list_page.dart';
import 'package:ecommerce_int2/screens/main/category_tabs.dart';
import 'package:ecommerce_int2/screens/notifications_page.dart';
import 'package:ecommerce_int2/screens/profile_page.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../change_notifiers/mainpage_notifier.dart';
import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: MainContent(),
      );
  }
}

class MainContent extends StatefulWidget {
  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent>
    with TickerProviderStateMixin<MainContent> {
  TabController? tabController;
  TabController? bottomTabController;
  bool isStateUpdated = false;

  List<Product> products = [];

  List<String> timelines = ['Featured products', 'Trending'];
  String selectedTimeline = 'Featured products';

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 10, vsync: this);
    bottomTabController = TabController(length: 10, vsync: this);
    print('initState');
    if (!isStateUpdated) {
      setState(() {
        isStateUpdated = true;
      });
    }
   
  }

  @override
  Widget build(BuildContext context) {
    print('building');
    MainPageNotifier mainPageNotifier = Provider.of<MainPageNotifier>(context, listen: true);

    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // TODO: IconButton(
          //     onPressed: () => Navigator.of(context)
          //         .push(MaterialPageRoute(builder: (_) => NotificationsPage())),
          //     icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SearchPage())),
              icon: SvgPicture.asset('assets/icons/search_icon.svg'))
        ],
      ),
    );

    Widget topHeader = Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[0];
                    products = mainPageNotifier.products;
                  });
                },
                child: Text(
                  timelines[0],
                  style: TextStyle(
                      fontSize: timelines[0] == selectedTimeline ? 20 : 14,
                      color:Colors.black,
                      ),
                ),
              ),
            ),
            Flexible(
              child: InkWell(
                onTap: () {
                  setState(() {
                    selectedTimeline = timelines[1];
                    products = mainPageNotifier.products;
                    ;
                  });
                },
                child: Text(timelines[1],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: timelines[1] == selectedTimeline ? 20 : 14,
                        color: darkGrey)),
              ),
            ),
          ],
        ));

    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController as TabController),
      body: CustomPaint(
          painter: MainBackground(),
          child: TabBarView(
            controller: bottomTabController,
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    // These are the slivers that show up in the "outer" scroll view.
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: appBar,
                      ),
                      SliverToBoxAdapter(
                        child: topHeader,
                      ),
                      Consumer<MainPageNotifier>(
                          builder: (context, productNotifier, _) {
                        return SliverToBoxAdapter(
                          child: ProductList(
                            products: mainPageNotifier.products,
                          ),
                        );
                      }),
                      SliverToBoxAdapter(
                        child: CategoryTabs(),
                      )
                    ];
                  },
                  body: Container()
                ),
              ),
              CategoryListPage(),
              CheckOutPage(),
              Consumer<UserNotifier>(
                builder: (context, userNotifier, _) { 
                  return Container(
                      child: LoginOrProfile() );
                },
              )
            ],
          )),
    );
  }
}


class LoginOrProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    UserNotifier userNotifier = Provider.of<UserNotifier>(context);

    return Container(
      child: FutureBuilder<bool>(
        future: userNotifier.checkIfLogged(),
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return ProfilePage(
                              logged_in_user: userNotifier.logged_in_user,
                            );
          } else {
            // After reading from storage, use the data to build your widget
            return LoginPage();
          }
        },
      ),
    );
  }
}