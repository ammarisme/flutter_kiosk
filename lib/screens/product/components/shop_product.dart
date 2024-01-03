import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/change_notifiers/product_notifier.dart';
import 'package:ecommerce_int2/models/cart.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopProduct extends StatelessWidget {
  final CartItem product;
  final VoidCallback onRemove;

  const ShopProduct(
    this.product, {
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          children: <Widget>[
            ShopProductDisplay(
              onPressed: onRemove,
              car_item: product,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: darkGrey,
                ),
              ),
            ),
            Text(
              '\Rs. ${product.salePrice}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: darkGrey, fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
          ],
        ));
  }
}

class ShopProductDisplay extends StatelessWidget {
  final CartItem car_item;
  final VoidCallback onPressed;

  const ShopProductDisplay({required this.car_item, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    Product? product;

    return FutureBuilder<Product?>(
        future: productNotifier.getProduct(this.car_item.product_id),
        builder: (context, snapshot) {
          product = snapshot.data;
          return product != null && product!.image != ""
              ? FadeInImage(
                  placeholder: AssetImage(
                      'assets/icons/logo_small.png'), // Placeholder image asset
                  image: NetworkImage(product!.image), // Network image URL
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                )
              : Image.asset('assets/icons/logo_small.png');
        });
  }
}
