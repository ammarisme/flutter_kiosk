// // Copyright 2013 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.
//
// // ignore_for_file: public_member_api_docs
//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:ecommerce_int2/screens/shop/select_payment_method.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// // #docregion platform_imports
// // Import for Android features.
// import 'package:webview_flutter_android/webview_flutter_android.dart';
//
// // Import for iOS features.
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// // #enddocregion platform_imports
//
// class CustomWebView extends StatefulWidget {
//   const CustomWebView({super.key});
//
//   @override
//   State<CustomWebView> createState() => _CustomWebViewState();
// }
//
// class _CustomWebViewState extends State<CustomWebView> {
//   late WebViewController _controller ;
//
//   void _loadUrl() async {
//     print("load url-----------------------------");
//     await _controller.runJavaScript('''
//     // Your JavaScript code to create and submit a POST request
//     // Replace 'https://your-post-url.com' with your target URL
//     // Customize the form fields and values as needed
//     var formData = new FormData();
//     formData.append('secret_key', '7a1b6b1a-ee25-4863-a92a-e528bc9e344a');
//     formData.append('payment', 'oAhrUqIKDdc0YmBtstIz8f0esI1DDiQ12tL9OFxIrZ1+nnrYpkytNt3AUoiJ7YC9ki8sxT6iwp34OEy868gWgKunDVr9XrLae/W5rIcWBjPd50diGjhWld0BiXNgQGK6bmYJKlLbauXO5rsVUtmeWSx1/JdkPwO4BBZVPmfbRgW+ayCV7VEiVy5XiM32R2QJGflfSwEvJzjjJlu9/oVttHm3iTGeUb2pYmkyinV/CjY3juZHrmXaSoISZ6vIVcG88D1Sh8YokVllGVohKyQ64l0K85SgKsMqmiveLtX+ksEDaF6siQmVnqoXaTjfFjlrYnSo5KmlE+51Yg52iWzv1g==');
//
//     fetch('https://stagingxpay.info/index.php?route=checkout/billing', {
//       method: 'POST',
//       body: formData
//     })
//     .then(response => response.text())
//     .then(data => {
//       console.log(data);
//     })
//     .catch(error => console.error('Error:', error));
//   ''');
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // #docregion platform_features
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }
//
//     _controller = WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features
//
//     _controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url
//                 .startsWith('https://flutter.dev/multi-platform/mobile')) {
//               // setState(() {
//               //   shouldCloseWebView = true;
//               // });
//               Navigator.of(context).pushReplacement(MaterialPageRoute(
//                   builder: (context) => SelectPaymentMethodPage()));
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//           onUrlChange: (UrlChange change) {
//             debugPrint('url change to ${change.url}');
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse('https://stagingxpay.info/index.php?route=checkout/billing'));
//       _loadUrl();
//     // #docregion platform_features
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _controller == null? Container(): Scaffold(
//       backgroundColor: Colors.green,
//       appBar: AppBar(
//         title: const Text('Flutter WebView example'),
//         // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
//         actions: <Widget>[
//           NavigationControls(webViewController: _controller),
//         ],
//       ),
//       body: WebViewWidget(controller: _controller),
//       floatingActionButton: favoriteButton(),
//     );
//   }
//
//   Widget favoriteButton() {
//     return FloatingActionButton(
//       onPressed: () async {
//         final String? url = await _controller.currentUrl();
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Favorited $url')),
//           );
//         }
//       },
//       child: const Icon(Icons.favorite),
//     );
//   }
// }
//
// class NavigationControls extends StatelessWidget {
//   const NavigationControls({super.key, required this.webViewController});
//
//   final WebViewController webViewController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () async {
//             if (await webViewController.canGoBack()) {
//               await webViewController.goBack();
//             } else {
//               if (context.mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('No back history item')),
//                 );
//               }
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.arrow_forward_ios),
//           onPressed: () async {
//             if (await webViewController.canGoForward()) {
//               await webViewController.goForward();
//             } else {
//               if (context.mounted) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('No forward history item')),
//                 );
//               }
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.replay),
//           onPressed: () => webViewController.reload(),
//         ),
//       ],
//     );
//   }
// }
