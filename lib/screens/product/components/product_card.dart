import 'dart:ffi';

import 'package:ecommerce_int2/api_services/product_apis.dart';
import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/screens/product/view_product_page.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: null,
        child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width / 2 - 29,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xfffbd085).withOpacity(0.46)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    width: MediaQuery.of(context).size.width / 2 - 64,
                    height: MediaQuery.of(context).size.width / 2 - 64,
                    child: Image.network(
                      product.image,
                    ),
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment(1, 0.5),
                    child: Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Color(0xffe0450a).withOpacity(0.51),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Text(
                          product.name,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        )),
                  ),
                )
              ],
            )));
  }
}


class ProductCardSelfLoad extends StatefulWidget {
  final String id;

  const ProductCardSelfLoad({required this.id});

 @override
  _ProductCardSelfLoad createState() => _ProductCardSelfLoad();
}

class _ProductCardSelfLoad extends State<ProductCardSelfLoad> {
  
Product? product;

@override
void initState() {
  super.initState();
  ProductAPIs.getProduct(widget.id).then((product) => 
  setState(() {
    this.product = product;
  })
  );
}

  @override
  Widget build(BuildContext context) {
    return product == null ? Container() : InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ViewProductPage(
                product: this.product as Product,
              )));
        },
        child: Container(
            height: 250,
            width: MediaQuery.of(context).size.width / 2 - 29,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color:PAGE_BACKGROUND_COLOR,),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                
               Image.network(
                      product!.image,
                    ),
               Positioned(
                  top:0,
                  left:0,
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.5,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(16, 0, 0, 0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Text(
                          product?.name as String,
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold
                          ),
                        )),
                  ),
  Positioned(
                  bottom:50,
                  right:0,
                    child: Container(
                      width: MediaQuery.of(context).size.width/4,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Text(
                          'Rs '+ Utils.thousandSeperate(product?.price as String) + '/=',
                          maxLines: 3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold
                          ),
                        )),
                  ),
 
  !product?.isOnSale() || product?.regular_price == "" ? Container() :  
  Positioned(
                  bottom:20,
                  right:0,
                    child: Container(
                      width: MediaQuery.of(context).size.width/4,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(16, 0, 0, 0),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10))),
                        child: Text(
                          'Rs '+ Utils.thousandSeperate(product?.regular_price as String) + '/=',
                          maxLines: 3,
                          textAlign: TextAlign.left,
                          
                          style: TextStyle(
                            fontSize: 10.0,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        )),
                  ),
 
               ],
            )));
  }
}
