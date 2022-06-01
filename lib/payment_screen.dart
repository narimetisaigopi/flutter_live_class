import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatelessWidget {
  int amount = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (ster) {
                amount = int.parse(ster);
              },
              decoration: InputDecoration(hintText: "Amount"),
            ),
            ElevatedButton(
                onPressed: () {
                  startPayment();
                },
                child: Text("Pay Now"))
          ],
        ),
      ),
    );
  }

  startPayment() {
    Razorpay _razorpay = Razorpay();

    var options = {
      'key': 'rzp_test_WC6D7YRBLtqmkC',
      'amount': amount * 100,
      'name': 'Cash Free Pvt Ltd',
      'description': 'Live class',
      'prefill': {'contact': '94293748747', 'email': 'saigopi@mgmail.com'}
    };

    _razorpay.open(options);

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}
