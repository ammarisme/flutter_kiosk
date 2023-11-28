import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _MyTestPageState createState() => _MyTestPageState();
}

class _MyTestPageState extends State<TermsAndConditionsPage> {
  bool section1Expanded = false;
  bool section2Expanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Test Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSection(
              header: 'Products, Pricing, Promotion Codes and Payments',
              content: [
                'Only genuine products which are directly sourced from manufacturers and authorized distributors are traded at Catlitter.lk.',
                'Prices are displayed in LKR inclusive of VAT.',
                'All images of the products are for illustration purpose only and the delivered product may slightly vary due to the changes made by the manufacturer.',
                'The stocks and prices of each product are subjected to change.',
                'All orders are subject to availability and acceptance by Catlitter.lk. We reserve the right to refuse or cancel any order.',
                'If Catlitter.lk is unable to deliver the goods ordered by you in the event of inadequate stocks, you will be notified as soon as possible and the relevant amount will be deducted from your payment. Either the customer will not be charged for the product that is out of stock or the relevant amount of money will be refunded. However, Catlitter.lk will not be responsible for any form of disappointment that the customer may suffer.',
                'Only one promotion code or gift voucher code can be redeemed against a single order.',
                'Special offer prices will be valid only if the item is purchased at the offer price during the time of the offer.',
                'Catlitter.lk will not offer a refund for items bought at a higher price when it was not on a special offer.',
                'Orders are subjected to extra security checks at the discretion of Catlitter.lk. This may include authentication of Credit/Debit card details and full address. Catlitter.lk reserves the right to request payment to be made by an alternative method or to cancel any order if this information cannot be supplied and authenticated. In instances where it is required that payment is made by cash or a bank transfer, Catlitter.lk reserve the right to allow a time period of 24 hours after the funds are received before the processing of your order is initiated.',
              ],
              isExpanded: false, // Set initial state as per your requirement
              onPressed: () {
                // Add any functionality here when the section is expanded or collapsed
              },
            ),
            _buildSection(
              header: 'Delivery',
              content: [
                'Catlitter.lk reserve the right to contact the customer directly regarding the orders made.',
                'Catlitter.lk reserves the right to deliver certain orders only to a Billing Address. In such instances customers will be notified by e-mail.',
                'In the event an order which is not collected by the customer is returned to Catlitter.lk by the postal or courier service the customer will be eligible to collect a refund. Catlitter.lk will not refund the postal charges and the customer will be notified of the return of the ordered products and the annulment of the order.',
                'In the event an order is not received Catlitter.lk must be notified in writing or by email within 45 working days of dispatch and no claim can be made after the time period.',
                'Catlitter.lk cannot be held responsible or liable for the delay or failure to deliver ordered goods. It is beyond the control of Catlitter.lk to prevent and damage or defect that may occur in the process of delivery.',
              ],
              isExpanded: false, // Set initial state as per your requirement
              onPressed: () {
                // Add any functionality here when the section is expanded or collapsed
              },
            ),
            _buildSection(
              header: 'Cancellation, Return and Refund',
              content: [
                'Customers are advised to check order details carefully before submitting orders as changes cannot be made once the order has been placed. Catlitter.lk will not grant compensation for inconvenience and/or loss experienced as a result.',
                'For a comprehensive guide on Catlitter.lk return policy please refer FAQ.',
              ],
              isExpanded: false, // Set initial state as per your requirement
              onPressed: () {
                // Add any functionality here when the section is expanded or collapsed
              },
            ),
            _buildSection(
              header: 'Complaints',
              content: [
                'Please contact us if you are unhappy with any of the services provided by Catlitter.lk.',
                'All complaints will be acknowledged within seven working days, and the customer will be informed of its status.',
              ],
              isExpanded: false, // Set initial state as per your requirement
              onPressed: () {
                // Add any functionality here when the section is expanded or collapsed
              },
            ),
            _buildSection(
              header: 'Changes to Term and Conditions',
              content: [
                'Catlitter.lk reserves the right to amend, modify the provided Terms and conditions including for legal, regulatory or security reasons.',
                'Whilst Catlitter.lk will notify the customers of major changes through the Website and/or emails, it is also the responsibility of the customer to check the Terms for changes.',
              ],
              isExpanded: false, // Set initial state as per your requirement
              onPressed: () {
                // Add any functionality here when the section is expanded or collapsed
              },
            ),
            _buildSection(
              header: 'Further Inquiries',
              content: [
                'Please contact us for further inquiries relating to the above stated terms and conditions.',
              ],
              isExpanded: false, // Set initial state as per your requirement
              onPressed: () {
                // Add any functionality here when the section is expanded or collapsed
              },
            )

          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String header,
    required List<String> content,
    required bool isExpanded,
    required VoidCallback onPressed,
  }) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          header,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content
                  .map(
                    (point) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 4.0,
                        height: 8.0,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black, // Change color if needed
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Expanded(child: Text(point, style: TextStyle(fontSize: 12),)),
                    ],
                  ),
                ),
              )
                  .toList(),
            ),
          ),
        ],
        onExpansionChanged: (expanded) {
          onPressed();
        },
        initiallyExpanded: isExpanded,
      ),
    );
  }
}
