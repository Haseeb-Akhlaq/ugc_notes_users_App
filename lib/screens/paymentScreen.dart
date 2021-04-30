import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ugc_net_notes/services/stripeService.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isLoading = false;
  final user = FirebaseAuth.instance.currentUser;

  Future updateFirebaseUserData() async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'premiumUser': true,
    });
  }

  sendPayements() async {
    setState(() {
      isLoading = true;
    });
    final response = await StripeService.payWithNewCard(
        amount: (2 * 100).toString(), currency: 'USD');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      backgroundColor: response.success ? Colors.black : Colors.red,
    ));
    setState(() {
      isLoading = false;
    });
    if (response.success) {
      await updateFirebaseUserData();
      Navigator.of(context).pop(true);
    }
  }

  @override
  void initState() {
    StripeService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy MemberShip'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Click The Card To Buy Member Ship',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      sendPayements();
                    },
                    child: Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '3-Months Rs 99',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendPayements();
                    },
                    child: Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '6-Months Rs 199',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendPayements();
                    },
                    child: Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            '1-Year Rs 299',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
