import 'package:flutter_wp_woocommerce/woocommerce.dart';

class WoocommerceAPI {
  static final String WRITE_API_KEY = 'ck_4e8b0b1c120f3705b6fb2439ac21f0395ff28cba';
  static final String WRITE_API_SECRET = "cs_7776fe061b9ea6853d41ab3b1f39201ae3e9e0ab";
  static final String BASE_URL = "https://catlitter.lk";
  
  static WooCommerce woocommerce = WooCommerce(
    baseUrl: BASE_URL,
    consumerKey: WRITE_API_KEY,
    consumerSecret: WRITE_API_SECRET);

  
}
