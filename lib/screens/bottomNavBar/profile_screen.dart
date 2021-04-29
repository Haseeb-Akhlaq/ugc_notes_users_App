import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/models/userModel.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userId = '';
  AppUser loggedUser;

  bool isLoading = true;

  getUserDetails() async {
    userId = FirebaseAuth.instance.currentUser.uid;

    print(userId);

    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final user =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!user.exists) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    print(user);

    loggedUser = AppUser.fromMap(user.data());

    print(loggedUser.email);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Profile'),
        backgroundColor: AppColors.primary,
      ),
      body: isLoading
          ? Center(
              child: SpinKitChasingDots(
                color: AppColors.primary,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileHeader(user: loggedUser),
                        DonationsPart(user: loggedUser),
                      ],
                    ),
                  ),
                  LogoutButton(),
                ],
              ),
            ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoogleSignIn().signOut();
        FirebaseAuth.instance.signOut();
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => AuthScreen(),
        //     ),
        //     (Route<dynamic> route) => false);
      },
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Logout',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class DonationsPart extends StatelessWidget {
  final AppUser user;
  const DonationsPart({this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 20, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        user.numberOfCourseEnrolled ?? '',
                        style: TextStyle(
                          fontSize: 42,
                        ),
                      ),
                      Text(
                        'Number of Courses Enrolled ',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        user.premiumUser.toString() ?? '',
                        style: TextStyle(
                          fontSize: 42,
                        ),
                      ),
                      Text(
                        'Premium User',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   alignment: Alignment.center,
            //   width: double.infinity,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     color: Color(0xffffcc00),
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: Text('Click To Share More'),
            // )
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final AppUser user;

  const ProfileHeader({this.user});

  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic ?? ''),
              radius: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.userName ?? '',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  user.email ?? '',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
