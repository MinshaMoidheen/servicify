import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:uuid/uuid.dart';

class CheckoutPage extends StatefulWidget {
 var walletid;
 var shopid;
 var bakance;
  final double totalPrice; // You need to calculate the total price based on your logic

  CheckoutPage({ this.shopid,required this.totalPrice,this.bakance,this.walletid});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  double estimatedTax = 0.0;
  double subtotal = 0.0;
  double total = 0.0;
  late Razorpay _razorpay = Razorpay();
  String? _name;
  String? _email;
  String? _phone;
  String? token;
  String? _location;
  var imggurl;

  Map<String, dynamic> data = {};
  String? _uid;
  getData() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    token = await _pref.getString('token');
    _name = await _pref.getString(
      'name',
    );

    _email = await _pref.getString(
      'email',
    );
    _phone = await _pref.getString(
      'phone',
    );
    _location = await _pref.getString(
      'location',
    );

    imggurl = await _pref.getString(
      'imgurl',
    );
    print(imggurl);

    // if (imggurl == null) {
    //   setState(() {
    //     imggurl = "assets/image/profile.png";
    //   });
    // }

    _uid = await _pref.getString(
      'uid',
    );

    print(data);
    setState(() {
      data = {
        "name": _name,
        "email": _email,
        "phone": _phone,
        "uid": _uid,


      };
    });
  }



  List<String>? courses;


  void handlePaymentErrorResponse(PaymentFailureResponse response){

    /** PaymentFailureResponse contains three values:
     * 1. Error Code
     * 2. Error Description
     * 3. Metadata
     **/
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {

    /** Payment Success Response contains three values:
     * 1. Order ID
     * 2. Payment ID
     * 3. Signature
     **/

    if(response.paymentId!=null){
var id=Uuid().v1();






{
  FirebaseFirestore.instance
      .collection('payments')
      .doc(response.paymentId)
      .set({
    'bookingid': id,
    'orderId': widget.walletid,
    'paymentid': response.paymentId,
    'paymenttitle': "Service Payment",
    'userid': _uid,
    'userEmail':_email,
    'userName':_name,
    'phone':_phone,
    'status': 1,
    'amount': total,
    'createdat': DateTime.now(),
    'settlementStatus': 0
  }).then((value) {
    
    FirebaseFirestore.instance.collection('appointment').doc(widget.walletid).update(
        {
          'status':2,
        });

    Navigator.pop(
        context);
  });
  //fiirebasecode
}

    }



    //showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }
  @override
  void dispose() {
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Map<String, dynamic> generateRazorpayOptions() {
    return {
      'key': 'rzp_test_7ERJiy5eonusNC',
      'amount': (total * 100).toInt(), // Convert total to integer (paise)
      'name': 'Servicify',
      'description': 'Service Charge',
      'prefill': {
        'contact': '9895663498',
        'email': 'support@ralfiz.com'
      }
    };
  }
  @override
  void initState() {
getData();
    calculateTotalValues();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
    super.initState();
  }

  void calculateTotalValues() {
    // Adjust the tax rate based on your requirements
    double taxRate = 0.18;

    // Calculate the subtotal, estimated tax, and total
    subtotal = widget.totalPrice;
    estimatedTax = subtotal * taxRate;
    total = subtotal + estimatedTax;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Checkout',style: TextStyle(color: Colors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cost Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Colors.black),
            ),
            SizedBox(height: 8),

            // Text(
            //   '${widget.course!['title']} - ${widget.course!['description']}',
            //   style: TextStyle(fontSize: 16,color: Colors.white),
            // ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Subtotal: \u{20B9}${widget.totalPrice.toStringAsFixed(2)}',
                   textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                ),
              ],
            ),
            Divider(
              thickness: 1.5, color: Colors.teal,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Estimated Tax (18%): \u{20B9}${estimatedTax.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 16,color: Colors.black),
                ),
              ],
            ),
            Divider(
              thickness: 1.5, color: Colors.teal,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Total: \u{20B9}${total.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.black),
                ),
              ],
            ),
            Divider(
              thickness: 1.5, color: Colors.teal,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                try{
                  _razorpay.open(generateRazorpayOptions());
                }catch(e){
                  print(e);
                }
                // Implement your payment logic here
                // You may want to use a payment gateway or navigate to a payment screen
                // For simplicity, let's print a message for now
                print('Payment successful. Course joined!');
                // You can also call the joinCourse method here if payment is successful
                // courseService.joinCourse(course.id, userId, booking);
              },
              child: Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
