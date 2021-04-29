import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/bottomNavBarScreen.dart';

import 'file:///C:/Users/haseeb/AndroidStudioProjects/ugc_net_notes/lib/screens/authScreen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return BottomNavBarScreen();
        }
        return AuthScreen();
      },
    );
  }
}
