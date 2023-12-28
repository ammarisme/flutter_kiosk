import 'dart:math';

import 'package:webxpay_flutter_sdk/domain/models/payment_request.dart';
import 'package:webxpay_flutter_sdk/webxpay_flutter_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key, required this.receiptNumber}) : super(key: key);

  final String receiptNumber;

  @override
  State<Checkout> createState() => _SdkState();
}

class _SdkState extends State<Checkout> {
  // Declare variables to control state of the app display
  bool isVisible = false;
  bool isButtonVisible = true;
  bool isReceiptVisible = true;
  String receiptNumber = "";
  String paymentStatusString = "";

  PaymentStatusCodes paymentStatus = PaymentStatusCodes.nil;

  @override
  void initState() {
    super.initState();
    receiptNumber = widget.receiptNumber;
    _initPlatformState();
  }

  // This is the public key that will be used to create data encyption.
  // This public should be available with the merchant upon registring with WebXPay
  final String _publicKey = """
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC8//PgSc2ell7KvHoWm6Zpp8Q8
G9hucpcGW3Fa2mGHhNSINUJaOhvHQUiRS416okP09v4zPPc42spz/rOQ0vO1zEck
BKn2c8NBEvgczKFFJXt3yx6wIsti0UlYPv1Q92QK0e/UqyDAMhstd6aCXNMOf75t
DRYbl9UiHppoTjHONwIDAQAB
-----END PUBLIC KEY-----
""";

  String publicKeyEncryptText = "";

  // Create a payment request object
  final PaymentRequest _paymentRequest = PaymentRequest(
    webXPaySessionLoginDetails: WebXPaySessionLoginDetails(
      username: "gen_agxintll",
      password: "qM^09QwQ)8ok",
    ),
    paymentDetails: PaymentDetails(
      amount: "2",
      currency: "LKR",
      bankMID: "WEBXPATOKLKR",
      orderNumber: "FGGGF3423423",
      customData: "",
    ),
    customer: Customer(
        id: "00003",
        email: "james@wxp.com",
        firstName: "james",
        lastName: "gordan",
        contactNumber: "0111111111",
        addressLineOne: "sample line1",
        city: "colombo",
        postalCode: "78151",
        country: "srilanka",
        state: "",
        addressLineTwo: ""),
    webXPaySessionConfiguration: WebXPaySessionConfiguration(
      webXPayEndPoint: "https://commtoken.webxpay.com/v1/api",
      webXPayRedirectURL:
      "https://webxpay.com/index.php?route=checkout/billing",
      secure3DResponseCallBackURL:
      "https://webxpay.com/index.php?route=checkout/payment/hostedCommercial3DSResponse&webx_mas_id=NzQ0Ng==",
      redirectResponseCallBackURL:
      "https://webxpay.com/index.php?route=checkout/payment/hostedCommercial3DSResponse&webx_mas_id=NzQ0Ng==",
      secretKey: "7a1b6b1a-ee25-4863-a92a-e528bc9e344a",
      encryptionMethod: "JCs3J+6oSz4V0LgE0zi/Bg==",
      redirectPaymentInfoEncrypted: "",
    ),
  );

  String _generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    String orderNumber =
    List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();

    _paymentRequest.updateOrderNumber(orderNumber);
    return orderNumber;
  }

  // Invoke the Method channel to call the platform specific code for data encryption

  Future<void> _getEncryptedString() async {
    String _key = _publicKey
        .replaceAll('\n', '')
        .replaceAll('-----BEGIN PUBLIC KEY-----', '')
        .replaceAll('-----END PUBLIC KEY-----', '');
    // print(_key);

    const platform = MethodChannel('webxpay.flutter.dev/encryptString');
    String encryptedString;
    try {
      encryptedString = await platform.invokeMethod('getEncryptedString', {
        'encryptionString': _paymentRequest.paymentDetails.orderNumber +
            "|" +
            _paymentRequest.paymentDetails.amount,
        'publickey': _key
      });
    } on PlatformException catch (e) {
      encryptedString = e.message.toString();
    }

    _paymentRequest.updateEncryptedRedirectPaymentInfo(encryptedString);
    setState(() {
      publicKeyEncryptText = encryptedString;
    });
  }

  void _initPlatformState() async {
    _generateRandomString(6);
    await _getEncryptedString();
  }

  // navigateToNextScreen(BuildContext context) {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => UserDetails()));
  // }

  void _payButtonHandler() {
    setState(() {
      paymentStatus = PaymentStatusCodes.pending;
      paymentStatusString = "Pending";
    });
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => WebXPayFlutterSdk(
    //           paymentRequest: _paymentRequest,
    //           voidCallback: _updatePaymentStatus,
    //         )));
  }

  void _updatePaymentStatus(
      PaymentStatusCodes _paymentStatus, String _receiptNumber) {
    setState(() {
      paymentStatus = _paymentStatus;
      receiptNumber = _receiptNumber;

      if (_paymentStatus == PaymentStatusCodes.timeout) {
        paymentStatusString = "Timedout";
      }
      if (_paymentStatus == PaymentStatusCodes.success) {
        paymentStatusString = "success";
      }
      if (_paymentStatus == PaymentStatusCodes.failure) {
        paymentStatusString = "failure";
      }
      if (_paymentStatus == PaymentStatusCodes.cancelled) {
        paymentStatusString = "cancelled";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: paymentStatus == PaymentStatusCodes.pending
            ? WebXPayFlutterSdk(
          paymentRequest: _paymentRequest,
          voidCallback: _updatePaymentStatus,
        )
            : Paynow(
          isReceiptVisible: isReceiptVisible,
          receiptNumber: receiptNumber,
          isProgressBarVisible: isVisible,
          isButtonVisible: isButtonVisible,
          payButtonHandler: _payButtonHandler,
          paymentStatusString: paymentStatusString,
        ),
      ),
    );
  }
}

class Paynow extends StatelessWidget {
  final bool isReceiptVisible;
  final String receiptNumber;
  final bool isProgressBarVisible;
  final bool isButtonVisible;
  final void Function() payButtonHandler;
  final String paymentStatusString;
  const Paynow(
      {Key? key,
        this.isReceiptVisible = false,
        this.receiptNumber = '',
        this.isProgressBarVisible = false,
        this.isButtonVisible = true,
        required this.payButtonHandler,
        this.paymentStatusString = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Amount : 100",
          style: TextStyle(fontSize: 20),
        ),
        Visibility(
          visible: isReceiptVisible,
          child: Text(
            "Receipt : $receiptNumber",
            style: TextStyle(fontSize: 15),
          ),
        ),
        Text(paymentStatusString),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            heightFactor: 0.30,
            widthFactor: 0.30,
            child: Visibility(
              visible: isProgressBarVisible,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                color: Colors.green,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Visibility(
            visible: isButtonVisible,
            child: TextButton(
              onPressed: payButtonHandler,
              child: Text("Pay",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ],
    );
  }
}
