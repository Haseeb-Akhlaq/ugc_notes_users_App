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

  String oneMonthPrice = '';
  String threeMonthPrice = '';
  String sixMonthPrice = '';
  String oneYearPrice = '';

  Future updateFirebaseUserData(int days) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'premiumUser': true,
      'memberShipValidTill':
          (DateTime.now().add(Duration(days: days))).toString()
    });
  }

  sendPayements({double price, int days}) async {
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
      await updateFirebaseUserData(days);
      Navigator.of(context).pop(true);
    }
  }

  fetchSubscriptionPrices() async {
    setState(() {
      isLoading = true;
    });
    final prices = await FirebaseFirestore.instance
        .collection('SubscriptionPrices')
        .doc('11221122')
        .get();

    print(prices.data()['1 Month']);

    setState(() {
      oneMonthPrice = prices.data()['1 Month'];
      threeMonthPrice = prices.data()['3 Months'];
      sixMonthPrice = prices.data()['6 Months'];
      oneYearPrice = prices.data()['1 Year'];
      isLoading = false;
    });
  }

  @override
  void initState() {
    StripeService.init();
    fetchSubscriptionPrices();
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
                      sendPayements(
                          price: double.parse(oneMonthPrice), days: 30);
                    },
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                oneMonthPrice,
                                style: TextStyle(
                                  fontSize: 38,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'For 1-Month ',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () async {
                      sendPayements(
                          price: double.parse(threeMonthPrice), days: 90);
                    },
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                threeMonthPrice,
                                style: TextStyle(
                                  fontSize: 38,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'For 3-Months ',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ],
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
                      sendPayements(
                          price: double.parse(sixMonthPrice), days: 180);
                    },
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                sixMonthPrice,
                                style: TextStyle(
                                  fontSize: 38,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'For 6-Months ',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ],
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
                      sendPayements(
                          price: double.parse(oneYearPrice), days: 365);
                    },
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                oneYearPrice,
                                style: TextStyle(
                                  fontSize: 38,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'For 1-Year ',
                                style: TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ],
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
