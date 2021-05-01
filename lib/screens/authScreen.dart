import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  void showErrSnackBar(
      {String message = 'Error Occurred', Color background = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: background,
      duration: Duration(seconds: 1),
    ));
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = Tween<double>(begin: 100, end: 60).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext c, _) {
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 250,
                  child: Image.asset('assets/logo.png'),
                ),
                SizedBox(
                  height: animation.value,
                ),
                GoogleButton(
                  showErr: showErrSnackBar,
                ),
                SizedBox(
                  height: 20,
                ),
                FacebookButton(showErr: showErrSnackBar),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GoogleButton extends StatefulWidget {
  final Function showErr;
  const GoogleButton({this.showErr});

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {
  signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await FirebaseAuth.instance.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        String userId = authResult.user.uid;

        final user = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (user.exists) {
          return;
        } else {
          final result = await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .set({
            'userName': authResult.user.displayName,
            'email': authResult.user.email,
            'userId': authResult.user.uid,
            'profilePic': authResult.user.photoURL,
            'totalCoursesEnrolled': '0',
            'premiumUser': false,
            'memberShipValidTill': '',
          });
        }
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Authentication Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign In aborted by user',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await signInWithGoogle();
        } catch (e) {
          widget.showErr();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.red.shade400,
                  Colors.blue.shade500,
                  Colors.green.shade100
                ]),
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 35,
                width: 35,
                child: Image.asset('assets/googlelogo.png'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Proceed with Google',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FacebookButton extends StatelessWidget {
  final Function showErr;

  const FacebookButton({this.showErr});

  signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final facebookAccount =
        await facebookLogin.logIn(['public_profile', 'email']);

    if (facebookAccount != null &&
        facebookAccount.status == FacebookLoginStatus.loggedIn) {
      final authResult = await FirebaseAuth.instance.signInWithCredential(
        FacebookAuthProvider.credential(facebookAccount.accessToken.token),
      );
      print(authResult.user);

      String userId = authResult.user.uid;

      print('--------------------------userID');
      print(userId);
      print('--------------------------userID');

      final user = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (user.exists) {
        return;
      } else {
        final result = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set({
          'userName': authResult.user.displayName,
          'email': authResult.user.email,
          'userId': authResult.user.uid,
          'profilePic': authResult.user.photoURL,
          'totalCoursesEnrolled': 0,
          'premiumUser': false,
          'memberShipValidTill': ''
        });
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign In aborted by user',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          await signInWithFacebook();
        } catch (e) {
          showErr();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                child: Image.asset('assets/facebooklogo.png'),
              ),
              SizedBox(
                width: 20,
              ),
              Text('Sign Up with facebook')
            ],
          ),
        ),
      ),
    );
  }
}
