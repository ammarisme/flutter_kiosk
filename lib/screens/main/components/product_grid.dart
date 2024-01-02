import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/product_page.dart';
import 'package:ecommerce_int2/screens/product/view_product_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class ProductGrid extends StatelessWidget {
  List<Product> products = [];
  String product_grid_title = "";

  ProductGrid({required this.products, required this.product_grid_title});

  @override
  Widget build(BuildContext context) {
    double cardWidth = MediaQuery.of(context).size.width / 2;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  color: THEME_COLOR_1,
                ),
              ),
              Container(
                width : 100,
                  
                  child: 
                  
                  Text(
                            product_grid_title,
                            maxLines: 3,
                            style:
                                TextStyle(color: Colors.white,
                                
                                 fontSize: 14.0,
                                overflow: TextOverflow.ellipsis
                                ),
                          ),
              )
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: MasonryGridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ViewProductPage(product: products[index]))),
                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(width: 0.5),
                      boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.7), // Shadow color and opacity
        spreadRadius: 10, // Spread radius
        blurRadius: 10, // Blur radius
        offset: Offset(0, 10), // Shadow position, positive values are below the widget
      ),
    ],
                      gradient: RadialGradient(
                          colors: [
                            Colors.grey.withOpacity(0.3),
                            Colors.grey.withOpacity(0.7),
                          ],
                          center: Alignment(0, 0),
                          radius: 0.6,
                          focal: Alignment(0, 0),
                          focalRadius: 0.1),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: products[index].image,
                              child: Image.network(products[index].image),
                            ),
                            Positioned(
                              top: 5,
                              left: 0,
                              child: Container(
                                width: cardWidth-40,
                                margin: const EdgeInsets.only(bottom: 12.0),
                                padding: const EdgeInsets.fromLTRB(
                                    8.0, 4.0, 12.0, 4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  color: THEME_COLOR_1.withOpacity(0.2), // Adjust the opacity if needed
                                ),
                                child: Text(
                                  '${products[index].name}',
                                  maxLines: 3,
                                  // Replace this with your price text
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,),
                                ),
                              ),
                            ),
                           

                                             Positioned(
                          bottom:35,
                          left:0,
                      child: 
                      Container(
                        width:MediaQuery.of(context).size.width/5.5,
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: PRICE_COLOR_SALE.withOpacity(0.7),
                        ),
                        child:
                         Text(
                          '\Rs. ${Utils.thousandSeperate(products[index].price)}',
                          
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        )
                        
                      ),
                    ),
                    products[index].isOnSale() ? 
                    Positioned(
                      bottom:-2,
                          left:0,
                      child: 
                      Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 12.0, 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          color: Colors.white.withOpacity(0.7),
                        ),
                        child:
                        Text(
                          '\Rs. ${Utils.thousandSeperate(products[index].regular_price)}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                               decoration: TextDecoration.lineThrough, // Add strikethrough effec
                              fontWeight: FontWeight.bold),
                        ),))
                      : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}
