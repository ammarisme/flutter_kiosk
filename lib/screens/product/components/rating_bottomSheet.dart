import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/product_notifier.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RatingBottomSheet extends StatefulWidget {
  Product product;

  RatingBottomSheet({required this.product});

  @override
  _RatingBottomSheetState createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  double rating = 0.0;
  List<int> ratings = [2, 1, 5, 2, 4, 3];

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    productNotifier.getProductReviews(widget.product, "22772");

    return Consumer<ProductNotifier>(builder: (context, productNotifier, _) {
      return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(24), topLeft: Radius.circular(24))),
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 92,
                    width: 92,
                    decoration: BoxDecoration(
                        color: PAGE_BACKGROUND_COLOR,
                        shape: BoxShape.circle,
                        boxShadow: shadow,
                        border: Border.all(width: 8.0, color: Colors.white)),
                    child: Image.network(widget.product.image),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 72.0, vertical: 16.0),
                    child: Text(
                      widget.product.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Text(
                        productNotifier.selected_product.product_overall_rating
                            .toString(),
                        //widget.product.product_overall_rating.toString(),
                        style: TextStyle(fontSize: 48),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        RatingBar(
//                      borderColor: Color(0xffFF8993),
//                      fillColor: Color(0xffFF8993),
                          ignoreGestures: true,
                          itemSize: 20,
                          allowHalfRating: true,
                          initialRating: productNotifier.selected_product.product_overall_rating,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          ratingWidget: RatingWidget(
                            empty: Icon(Icons.favorite_border,
                                color: Color(0xffFF8993), size: 20),
                            full: Icon(
                              Icons.favorite,
                              color: Color(0xffFF8993),
                              size: 20,
                            ),
                            half: SizedBox(),
                          ),
                          onRatingUpdate: (value) {
                            setState(() {
                              rating = productNotifier.selected_product.product_overall_rating;
                            });
                            print(value);
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                              'from ${productNotifier.selected_product.product_reviews.length} '
                                  '${productNotifier.selected_product.product_reviews.length>1 ? 'people' : 'person'}'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Align(
                    alignment: Alignment(-1, 0), child: Text('Recent Reviews')),
              ),
              Column(
                children: <Widget>[
                  ...productNotifier.selected_product.product_reviews
                      .map((review) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: CircleAvatar(
                                  maxRadius: 14,
                                  backgroundImage: NetworkImage(review.reviewer_avatar_urls),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          review.reviewer,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          DateFormat.yMMMMd().add_jms().format(DateTime.parse(review.date_created)),
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 10.0),
                                        )
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: RatingBar(
                                        ignoreGestures: true,
                                        itemSize: 20,
                                        allowHalfRating: true,
                                        initialRating: review.rating.toDouble(),
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        ratingWidget: RatingWidget(
                                          empty: Icon(Icons.favorite_border,
                                              color: Color(0xffFF8993),
                                              size: 20),
                                          full: Icon(
                                            Icons.favorite,
                                            color: Color(0xffFF8993),
                                            size: 20,
                                          ),
                                          half: SizedBox(),
                                        ),
                                        onRatingUpdate: (value) {
                                          setState(() {
                                            rating = review.rating.toDouble();
                                          });
                                          print(value);
                                        },
                                      ),
                                    ),
                                    Html(data: review.review),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '21 likes',
                                            style: TextStyle(
                                                color: Colors.grey[400],
                                                fontSize: 10.0),
                                          ),
                                          Text(
                                            '1 Comment',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10.0),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )))
                      .toList()
                ],
              )
            ],
          ));
    });
  }
}
