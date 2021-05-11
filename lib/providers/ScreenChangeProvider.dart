import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenChangeProvider extends ChangeNotifier {
  int currentIndex = 0;
  PageController controller;
  String validityDays = '';
  int done = 0;

  setPageController(PageController con) {
    controller = con;
  }

  int getScreenIndex() {
    return currentIndex;
  }

  changeScreenIndex(int index) {
    currentIndex = index;
    controller.animateToPage(index,
        duration: Duration(microseconds: 600), curve: Curves.linear);
    done = 0;
    notifyListeners();
  }

  getValidityDays() async {
    print('doodododo');
    final userId = FirebaseAuth.instance.currentUser.uid;
    final user =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    final validity = user.data()['memberShipValidTill'];

    if (validity != '') {
      final date = DateTime.parse(validity).difference(DateTime.now());

      validityDays = date.inDays.toString();
    } else {
      validityDays = '0';
    }

    if (done == 0) {
      done++;
      notifyListeners();
    }
  }
}
