import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/models/userModel.dart';
import 'package:ugc_net_notes/widgets/drawer.dart';

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
      drawer: ScreenDrawer(),
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
                        InfoPart(user: loggedUser),
                        PremiumUserPart(user: loggedUser)
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
        FacebookLogin().logOut();
        FirebaseAuth.instance.signOut();
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

class InfoPart extends StatelessWidget {
  final AppUser user;
  const InfoPart({this.user});

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
                        user.numberOfCourseEnrolled.toString() ?? '',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PremiumUserPart extends StatelessWidget {
  final AppUser user;
  const PremiumUserPart({this.user});

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
                        'Premium Membership Till:  ',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        user.memberShipValidTill == ''
                            ? '0 Days'
                            : DateFormat.yMMMMd().format(
                                DateTime.parse(user.memberShipValidTill)),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            Expanded(
              child: ListTile(
                title: Text(
                  user.userName ?? '',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  user.email ?? '',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 10,
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
