


import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app_properties.dart';
import 'components/more_products.dart';
import 'components/product_options.dart';
import 'package:html/parser.dart';

//import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // Import InAppWebView package


class ViewProductPage extends StatefulWidget {
  Product product;

  ViewProductPage({required this.product});

  @override
  _ViewProductPageState createState() => _ViewProductPageState();
}

class _ViewProductPageState extends State<ViewProductPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Product? product = null;
  int active = 0;
  bool product_loaded = false;
  
@override
void initState() {
  super.initState();
  // Make API call here
  ProductAPIs.getProduct(widget.product.id.toString()).
  then((product) => 
  setState(() {
    if (product!.attributes.length > 0 && product.attributes[0].options.length > 0) {
    widget.product.brand_name = product.attributes[0].options[0] as String;
    }
    product_loaded = true;
  })
  );

  ProductAPIs.getProduct(widget.product.id.toString()).
  then((product) => 
  setState(() {
    if (product!.attributes.length > 0 && product.attributes[0].options.length > 0) {
    widget.product.brand_name = product.attributes[0].options[0] as String;
    }
    product_loaded = true;
  })
  );

  ProductAPIs.getProductRating(widget.product.id.toString()).
  then((rating) => 
  setState(() {
    widget.product.rating = rating; 
  }));

 ProductAPIs.getProductVariations(widget.product.id.toString()).
  then((variations) => 
  setState(() {
    widget.product.variations = variations; 
  }));

}

  ///list of product colors
  List<Widget> variations() {
    List<Widget> list = [];
    for (int i = 0; i < 5; i++) {
      list.add(
        InkWell(
          onTap: () {
            setState(() {
              active = i;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: Transform.scale(
              scale: active == i ? 1.2 : 1,
              child: Card(
                elevation: 3,
                color: Colors.black,
                child: SizedBox(
                  height: 32,
                  width: 32,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Widget description =
    Container(
    child:
    Padding(
      padding: const EdgeInsets.only(left : 10.0),
      child: Html(data: getCleanHTML(widget.product.description))
    ));

    // Widget variation_selector = Padding(
    //                   padding: const EdgeInsets.all(24.0),
    //                   child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
    //                     Flexible( // set depending on variations.
    //                       child: ColorList([
    //                         Colors.black,
    //                         Colors.blue,
    //                         Colors.purple,
    //                         Colors.green,
    //                         Colors.yellow
    //                       ]),
    //                     ), //Color options
    //                     RawMaterialButton(
    //                       onPressed: () {
    //                         showModalBottomSheet(
    //                           context: context,
    //                           builder: (context) {
    //                             return RatingBottomSheet(product: widget.product);
    //                           },
    //                           //elevation: 0,
    //                           //backgroundColor: Colors.transparent
    //                         );
    //                       },
    //                       constraints:
    //                       const BoxConstraints(minWidth: 45, minHeight: 45),
    //                       child: Icon(Icons.favorite,
    //                           color: Color.fromRGBO(255, 137, 147, 1)),
    //                       elevation: 0.0,
    //                       shape: CircleBorder(),
    //                       fillColor: Color.fromRGBO(255, 255, 255, 0.4),
    //                     ),
    //                   ]),
    //                 );

    return Scaffold(
            key: _scaffoldKey,
            backgroundColor: PAGE_BACKGROUND_COLOR_2,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: darkGrey),
              actions: <Widget>[
                IconButton(
                  icon: new SvgPicture.asset(
                    'assets/icons/search_icon.svg',
                    fit: BoxFit.scaleDown,
                  ),
                  onPressed: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => SearchPage())),
                )
              ],
              title: Text(
                'Product',
                style: const TextStyle(
                    color: darkGrey,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Montserrat",
                    fontSize: 18.0),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    product_loaded ?
                    ProductOption(
                      _scaffoldKey,
                      product: widget.product,
                    ) : Container(),
                    description,
                    MoreProducts(product_ids: widget.product.related_ids,)
                  ],
                ),
              ),
            )
    );
  }
  



//here goes the function 
String getCleanHTML(String htmlString) {
final document = parse(htmlString);
if (document.getElementById("manufacturer") != null){
document.getElementById("manufacturer")!.remove();
}
return  document.outerHtml;
}
}