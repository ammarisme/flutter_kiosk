class Cart {
  List<dynamic> coupons;
  List<dynamic> shippingRates;
  Address shippingAddress;
  Address billingAddress;
  List<CartItem> items;
  int itemsCount;
  int itemsWeight;
  List<dynamic> crossSells;
  bool needsPayment;
  bool needsShipping;
  bool hasCalculatedShipping;
  List<dynamic> fees;
  Totals totals;
  List<dynamic> errors;
  List<String> paymentRequirements;
  // Map<String, dynamic> extensions;

  Cart({
    required this.coupons,
    required this.shippingRates,
    required this.shippingAddress,
    required this.billingAddress,
    required this.items,
    required this.itemsCount,
    required this.itemsWeight,
    required this.crossSells,
    required this.needsPayment,
    required this.needsShipping,
    required this.hasCalculatedShipping,
    required this.fees,
    required this.totals,
    required this.errors,
    required this.paymentRequirements,
    // required this.extensions,
  });


  factory Cart.fromJson(Map<String, dynamic> json) {
    List<CartItem> items = (json['items'] as List<dynamic>).map((item) => CartItem.fromJson(item)).toList();

    return Cart(
      coupons: json['coupons'] ?? [],
      shippingRates: json['shipping_rates'] ?? [],
      shippingAddress: Address.fromJson(json['shipping_address'] ?? {}),
      billingAddress: Address.fromJson(json['billing_address'] ?? {}),
      items: items ?? [],
      itemsCount: json['items_count'] ?? 0,
      itemsWeight: json['items_weight'] ?? 0,
      crossSells: json['cross_sells'] ?? [],
      needsPayment: json['needs_payment'] ?? false,
      needsShipping: json['needs_shipping'] ?? false,
      hasCalculatedShipping: json['has_calculated_shipping'] ?? false,
      fees: json['fees'] ?? [],
      totals: Totals.fromJson(json['totals'] ?? {}),
      errors: json['errors'] ?? [],
      paymentRequirements: List<String>.from(json['payment_requirements'] ?? []),
      // extensions: json['extensions'] ?? {},
    );
  }
}

class Address {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String state;
  String postcode;
  String country;
  String email;
  String phone;

  Address({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    required this.email,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      company: json['company'] ?? '',
      address1: json['address_1'] ?? '',
      address2: json['address_2'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      postcode: json['postcode'] ?? '',
      country: json['country'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }
}

class Totals {
  String totalItems;
  String totalItemsTax;
  String totalFees;
  String totalFeesTax;
  String totalDiscount;
  String totalDiscountTax;
  dynamic totalShipping;
  dynamic totalShippingTax;
  String totalPrice;
  String totalTax;
  List<dynamic> taxLines;
  String currencyCode;
  String currencySymbol;
  int currencyMinorUnit;
  String currencyDecimalSeparator;
  String currencyThousandSeparator;
  String currencyPrefix;
  String currencySuffix;

  Totals({
    required this.totalItems,
    required this.totalItemsTax,
    required this.totalFees,
    required this.totalFeesTax,
    required this.totalDiscount,
    required this.totalDiscountTax,
    required this.totalShipping,
    required this.totalShippingTax,
    required this.totalPrice,
    required this.totalTax,
    required this.taxLines,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyMinorUnit,
    required this.currencyDecimalSeparator,
    required this.currencyThousandSeparator,
    required this.currencyPrefix,
    required this.currencySuffix,
  });

  factory Totals.fromJson(Map<String, dynamic> json) {
    return Totals(
      totalItems: json['total_items'] ?? '0',
      totalItemsTax: json['total_items_tax'] ?? '0',
      totalFees: json['total_fees'] ?? '0',
      totalFeesTax: json['total_fees_tax'] ?? '0',
      totalDiscount: json['total_discount'] ?? '0',
      totalDiscountTax: json['total_discount_tax'] ?? '0',
      totalShipping: json['total_shipping'],
      totalShippingTax: json['total_shipping_tax'],
      totalPrice: json['total_price'] ?? '0',
      totalTax: json['total_tax'] ?? '0',
      taxLines: json['tax_lines'] ?? [],
      currencyCode: json['currency_code'] ?? '',
      currencySymbol: json['currency_symbol'] ?? '',
      currencyMinorUnit: json['currency_minor_unit'] ?? 2,
      currencyDecimalSeparator: json['currency_decimal_separator'] ?? '.',
      currencyThousandSeparator: json['currency_thousand_separator'] ?? ',',
      currencyPrefix: json['currency_prefix'] ?? '',
      currencySuffix: json['currency_suffix'] ?? '',
    );
  }
}


class CartItem {
  final String key;
  final int id;
  final int quantity;
  final String name;
  final String? lowStockRemaining;
  final String regularPrice;
  final String salePrice;
  final String currencyCode;
  final String currencySymbol;
  final String lineTotalTax;
  final int currencyMinorUnit;
  final String currencyPrefix;

  CartItem({
    required this.key,
    required this.id,
    required this.quantity,
    required this.name,
    this.lowStockRemaining,
    required this.regularPrice,
    required this.salePrice,
    required this.currencyCode,
    required this.currencySymbol,
    required this.lineTotalTax,
    required this.currencyMinorUnit,
    required this.currencyPrefix,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      key: json['key'] ?? '',
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      name: json['name'] ?? '',
      lowStockRemaining: json['low_stock_remaining'],
      regularPrice: json['prices']['regular_price'] ?? 0,
      salePrice: json['prices']['sale_price'] ?? 0,
      currencyCode: json['totals']['currency_code'] ?? '',
      currencySymbol: json['totals']['currency_symbol'] ?? '',
      lineTotalTax: json['totals']['line_total_tax'] ?? '',
      currencyMinorUnit: json['totals']['currency_minor_unit'] ?? 0,
      currencyPrefix: json['totals']['currency_prefix'] ?? '',
    );
  }
}
