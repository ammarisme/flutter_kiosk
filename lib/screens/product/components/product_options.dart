import 'package:ecommerce_int2/app_properties.dart';
import 'package:ecommerce_int2/common/utils.dart';
import 'package:ecommerce_int2/models/product.dart';
import 'package:ecommerce_int2/models/product_variation.dart';
import 'package:ecommerce_int2/screens/product/components/rating_bottomSheet.dart';
import 'package:ecommerce_int2/screens/shop/check_out_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../change_notifiers/cart_notifiers.dart';

class ProductOption extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Product product;
  const ProductOption(
    this.scaffoldKey, {
    required this.product,
  });

  @override
  _ProductOptionState createState() => _ProductOptionState();
}

class _ProductOptionState extends State<ProductOption> {
  List<DropdownMenuItem<String>> dropdownItems = [];
  ProductVariation? selectedVariation;
  var selectedValue;

  @override
  void initState() {
    super.initState();

    selectedVariation = ProductVariation(
        attributes: widget.product.attributes,
        stock_quantity: widget.product.stock_quantity,
        id: widget.product.id,
        weight: widget.product.weight,
        sale_price: widget.product.price,
        regular_price: widget.product.regular_price);

    try {
      if (widget.product.variations.length > 0) {
        ProductVariation first_variation = widget.product.variations.first;
        setState(() {
        selectedValue = first_variation.attributes[0]["option"];
        selectedVariation = ProductVariation(
            attributes: first_variation.attributes,
            stock_quantity: first_variation.stock_quantity,
            id: first_variation.id,
            weight: first_variation.weight,
            sale_price: first_variation.sale_price,
            regular_price: first_variation.regular_price);  
        });
        
      }
    } catch (ex, stackTrace) {
      print(ex);
      print(stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);

    return SizedBox(
      height: 450,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 10,
            top: 10,
            width: MediaQuery.of(context).size.width / 1.4,
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(20.0), // Adjust the radius as needed
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                ),
                child: Image.network(widget.product.image, fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child; // Return the actual image widget if the image is fully loaded
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
          Positioned(
            width: MediaQuery.of(context).size.width / 1.5,
            top: 20,
            left: 20,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(16, 0, 0, 0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                widget.product.name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0.0,
            top: 10,
            child: Container(
              height: 220,
              width: 280,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      if (getStockQuantity() > 0) {
                        Utils.showToast(
                            "Adding ${1} ${widget.product.name} to your cart.",
                            ToastType.done_success);
                        cartNotifier
                            .addItem(getSelectedProductId(), 1)
                            .then((value) {
                          Utils.showToast(
                              "Successfully added ${1} ${widget.product.name} to your cart.",
                              ToastType.done_success);

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => CheckOutPage()));
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width /
                          MAIN_BUTTON_FACTOR,
                      decoration: BoxDecoration(
                          color: getStockQuantity() > 0
                              ? BUTTON_COLOR_1
                              : BUTTON_COLOR_1_INACTIVE,
                          gradient: MAIN_BUTTON_GRADIENTS,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_bag,
                              color:
                                  BUTTON_TEXT_COLOR1, // Set icon color as needed
                              size: BUTTON_ICON_SIZE),
                          SizedBox(
                              width:
                                  3), // Adjust the space between text and icon
                          Text(
                            'Buy Now',
                            style: TextStyle(
                              color: BUTTON_TEXT_COLOR1,
                              fontWeight: FontWeight.bold,
                              fontSize: BUTTON_FONT_SIZE,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (getStockQuantity() > 0) {
                        showAddToCartDialog(cartNotifier);
                                          } else if (getStockQuantityOfAllVariations() > 0){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      'Please pick a product option before adding to cart!'),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                        showVariantPickerDialog(cartNotifier);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width /
                          MAIN_BUTTON_FACTOR,
                      decoration: BoxDecoration(
                          color: getStockQuantityOfAllVariations() > 0
                              ? BUTTON_COLOR_1
                              : BUTTON_COLOR_1_INACTIVE,
                          gradient: MAIN_BUTTON_GRADIENTS,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              bottomLeft: Radius.circular(10.0))),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined,
                              color:
                                  BUTTON_TEXT_COLOR1, // Set icon color as needed
                              size: BUTTON_ICON_SIZE),
                          SizedBox(width: 3),
                          Text(
                            getStockQuantityOfAllVariations() > 0
                                ? 'Add to cart'
                                : 'Out of stock',
                            style: TextStyle(
                              color: BUTTON_TEXT_COLOR1,
                              fontWeight: FontWeight.bold,
                              fontSize: BUTTON_FONT_SIZE,
                            ),
                          ),
                          // Adjust the space between text and icon
                        ],
                      ),
                    ),
                  ),
          

                  widget.product.rating == 0
                      ? Container()
                      : InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return RatingBottomSheet(
                                    product: widget.product);
                              },
                              //elevation: 0,
                              //backgroundColor: Colors.transparentb
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width /
                                MAIN_BUTTON_FACTOR,
                            decoration: BoxDecoration(
                                color: getStockQuantity() > 0
                                    ? BUTTON_COLOR_1
                                    : BUTTON_COLOR_1_INACTIVE,
                                gradient: MAIN_BUTTON_GRADIENTS,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0))),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.product.rating.toString(),
                                  style: TextStyle(
                                    color: BUTTON_TEXT_COLOR1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: BUTTON_FONT_SIZE,
                                  ),
                                ),
                                SizedBox(width: 3),
                                Icon(Icons.star_outline,
                                    color:
                                        BUTTON_TEXT_COLOR1, // Set icon color as needed
                                    size: BUTTON_ICON_SIZE),
                                SizedBox(width: 3),

                                // Adjust the space between text and icon
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 40,
            top: 320,
            child: Stack(
              children: [
                Container(
                  // Container to mimic the background
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '\Rs. ' +
                              Utils.thousandSeperate(
                                  selectedVariation?.sale_price as String) +
                              '/=',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat",
                            fontSize: 20.0,
                          ),
                        ),
                        TextSpan(
                          text: '.00',
                          style: const TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat",
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    // Prevents the Container from intercepting user input
                    child: Container(
                      color: Colors.orange
                          .withOpacity(0.5), // Orange color with opacity
                    ),
                  ),
                ),
              ],
            ),
          ),
          (selectedVariation?.sale_price == selectedVariation?.regular_price ||
                  selectedVariation?.regular_price == "")
              ? Container()
              : Positioned(
                  left: 60,
                  top: 345,
                  child: Stack(
                    children: [
                      Container(
                        // Container to mimic the background
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '\Rs. ' +
                                    Utils.thousandSeperate(selectedVariation
                                        ?.regular_price as String) +
                                    '/=',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat",
                                  fontSize: 16.0,
                                  decoration: TextDecoration
                                      .lineThrough, // Add strikethrough effect
                                ),
                              ),
                              TextSpan(
                                text: '.00',
                                style: const TextStyle(
                                  color: const Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Montserrat",
                                  fontSize: 14.0,
                                  decoration: TextDecoration
                                      .lineThrough, // Add strikethrough effect
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: IgnorePointer(
                          // Prevents the Container from intercepting user input
                          child: Container(
                            color: Color.fromARGB(255, 172, 172, 172)
                                .withOpacity(0.5), // Orange color with opacity
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Positioned(
              top: 370,
              left: 10,
              child: Container(
                  height: 100,
                  width: 300,
                  child: Row(children: [
                    widget.product.brand_name != ""
                        ? Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color:
                                      Colors.black, // Set border color to black
                                  width: 1.0, // Set border width
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Brand: " + widget.product.brand_name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: BUTTON_FONT_SIZE,
                                  ),
                                ),
                                // Adjust the space between text and icon
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(width: 5),
                    // if there are weight attributes, load a dropdown.
                    //else if  there is a weight value, show the weight.
                    // else show none.
                    hasVariants()
                        ? CustomButton(buttontext: "Pick an option" + (selectedValue!= null && selectedValue!=""? "\n(selected : ${selectedValue})": ""), onTap: (){
                          showVariantPickerDialog(cartNotifier);
                    }, enabled: true, size: ButtonSize.large):Container()
                  ])))
        ],
      ),
    );
  }

  bool hasVariants() {
    return (widget.product.variations != null &&
        widget.product.variations.length > 0);
  }

  int getStockQuantity() {
    if (selectedVariation != null) {
      return selectedVariation!.stock_quantity;
    }
    return widget.product.stock_quantity;
  }

  int getStockQuantityOfAllVariations() {
     int total_stock = widget.product.variations.fold(
        0,
        (sum, lineItem) =>
            sum + (lineItem.stock_quantity));
      return total_stock + widget.product.stock_quantity;
  }

  List<ProductVariation> getVariations() {
    return widget.product.variations;
  }

  int getSelectedProductId() {
    if (selectedVariation != null) {
      return selectedVariation!.id;
    }
    return widget.product.id;
  }

  void selectVariation(mySelectedVariation) {
    setState(() {
      selectedVariation = mySelectedVariation;
      selectedValue = mySelectedVariation.attributes[0]["option"];
    });
  }
  
  void showVariantPickerDialog(cartNotifier) {
    var variations = getVariations();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Pick an option'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Table(
                                          border: TableBorder.all(),
                                          children: [
                                            TableRow(
                                              children: [
                                                TableCell(
                                                    child: Padding(
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              variations[0]
                                                                      .attributes[
                                                                  0]["name"],
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )))),
                                                TableCell(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10,
                                                                right: 5,
                                                                left: 5),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              'Price',
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )))),
                                                TableCell(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 10,
                                                                right: 5,
                                                                left: 5),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text('')))),
                                              ],
                                            ),
                                            for (int index = 0;
                                                index < variations.length;
                                                index++)
                                              TableRow(
                                                children: [
                                                  TableCell(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        right: 5,
                                                        left: 5),
                                                    child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                            ' ${variations[index].attributes[0]["option"]}')),
                                                  )),
                                                  TableCell(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        right: 5,
                                                        left: 5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        'Rs ${Utils.thousandSeperate(variations[index].sale_price)}/=',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    ),
                                                  )),
                                                  TableCell(
                                                      child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        right: 5,
                                                        left: 5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: CustomButton(
                                                        size: ButtonSize.small,
                                                        enabled:variations[
                                                                        index]
                                                                    .stock_quantity >
                                                                0 ,
                                                        buttontext: variations[
                                                                        index]
                                                                    .stock_quantity >
                                                                0
                                                            ? 'Select option'
                                                            : 'Out of stock',
                                                        onTap: () {
                                                          selectVariation(
                                                              variations[
                                                                  index]);
                                                          Navigator.of(context)
                                                              .pop(); // Clo
                                                                  showAddToCartDialog(cartNotifier);

                                                        },
                                                      ),
                                                    ),
                                                  )),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
  
  }
  
  void showAddToCartDialog(cartNotifier) {
        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            int quantity = 1;
                            TextEditingController quantityController =
                                TextEditingController(text: '1');

                            void incrementQuantity() {
                              setState(() {
                                if (quantity + 1 > getStockQuantity()) {
                                  quantity = getStockQuantity();
                                } else {
                                  quantity++;
                                  quantityController.text = quantity.toString();
                                }
                              });
                            }

                            void decrementQuantity() {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                  quantityController.text = quantity.toString();
                                });
                              }
                            }

                            return AlertDialog(
                              title: Text('Add to Cart'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                
                                  Text(
                                      (selectedValue!= null ? 'Option: ${selectedValue} / ' : "") + 'Available stock : ${getStockQuantity()}', style: TextStyle(fontSize: 12),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: decrementQuantity,
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: TextField(
                                          controller: quantityController,
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            quantity = int.tryParse(value) ?? 1;
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: incrementQuantity,
                                      ),
                                    ],
                                  ),
                                                                 ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    // Add item to cart with the selected quantity
                                    Utils.showToast(
                                        "Adding ${quantity} ${widget.product.name} to your cart.",
                                        ToastType.done_success);
                                    cartNotifier
                                        .addItem(
                                            getSelectedProductId(), quantity)
                                        .then((value) {
                                      Utils.showToast(
                                          "Successfully added ${quantity} ${widget.product.name} to your cart.",
                                          ToastType.done_success);
                                    });
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Add'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );

  }
}

enum ButtonSize{
small,
large
}

class CustomButton extends StatelessWidget {
  final String buttontext;
  final void Function() onTap;
  bool enabled;
  ButtonSize size;

  CustomButton({required this.buttontext, required this.onTap, required this.enabled, required this.size});
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          this.onTap();
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2.7,
          decoration: BoxDecoration(
              color: this.enabled ? BUTTON_COLOR_1 : BUTTON_COLOR_1_INACTIVE,
              border: Border.all(
                color:this.enabled ? BUTTON_COLOR_1 : BUTTON_COLOR_1_INACTIVE, // Set border color to black
                width: 1.0, // Set border width
              ),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          padding: EdgeInsets.symmetric(vertical: this.size == ButtonSize.small ?  5.0: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttontext,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: this.size == ButtonSize.small ?  SMALL_BUTTON_FONT_SIZE : BUTTON_FONT_SIZE,
                ),
              ),
              // Adjust the space between text and icon
            ],
          ),
        ));
  }
}
