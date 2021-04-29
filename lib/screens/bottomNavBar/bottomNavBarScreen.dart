import 'package:flutter/material.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/homeScreen.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/notificationsScreen.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/profile_screen.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/subjectsScreen.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/whatsAppScreen.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;
  PageController _pageController = PageController();

  void changeIndex({index}) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(selectedIndex,
          duration: Duration(microseconds: 600), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            print(selectedIndex);
            selectedIndex = index;
            _pageController.animateToPage(selectedIndex,
                duration: Duration(microseconds: 600), curve: Curves.linear);
          });
        },
        elevation: 10,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.primary,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // BottomNavigationBarItem(
          //     icon: Icon(Icons.favorite_sharp), label: 'Subscription'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.book,
              ),
              label: 'Subjects'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: 'Profile'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
              ),
              label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              label: 'WhatsApp'),
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: [
          HomeScreen(),
          SubjectsScreen(),
          ProfileScreen(),
          NotificationsScreen(),
          WhatsAppScreen(),
        ],
      ),
    );
  }
}
