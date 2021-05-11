import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/providers/ScreenChangeProvider.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/homeScreen.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/notitficationScreen.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/profile_screen.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/subjectsScreen.dart';
import 'package:ugc_net_notes/screens/bottomNavBar/whatappScreen.dart';

class BottomNavBarScreen extends StatefulWidget {
  @override
  _BottomNavBarScreenState createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int selectedIndex = 0;
  PageController _pageController = PageController();
  FlutterLocalNotificationsPlugin fltrNotification;

  void changeIndex({index}) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(selectedIndex,
          duration: Duration(microseconds: 600), curve: Curves.linear);
    });
  }

  Future notificationSelected(String payload) async {
    Provider.of<ScreenChangeProvider>(context, listen: false)
        .setPageController(_pageController);
    Provider.of<ScreenChangeProvider>(context, listen: false)
        .changeScreenIndex(3);
  }

  DateTime particularTime(DateTime datefornoti, String timeInHours) {
    String todayDate = datefornoti.toString();
    String date = todayDate.split(' ')[0];
    date = '$date $timeInHours';
    final finalDate = DateTime.parse(date);
    return finalDate;
  }

  configureLocalTimeZone(DateTime notificationTime) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));

    var time = tz.TZDateTime.from(
      notificationTime,
      tz.local,
    );

    return time;
  }

  Future _showNotification1(DateTime timefornoti) async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID 1",
      "wesdok 1",
      "This is my channel 1",
      importance: Importance.max,
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    final time = await configureLocalTimeZone(timefornoti);

    await fltrNotification.zonedSchedule(
      0,
      'Daily Question 1',
      'click here to see question',
      time,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  Future _showNotification2(DateTime timefornoti) async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID 1",
      "wesdok 2",
      "This is my channel 2",
      importance: Importance.max,
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    final time = await configureLocalTimeZone(timefornoti);

    await fltrNotification.zonedSchedule(
      1,
      'Daily Question 2',
      'click here to see question',
      time,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  Future _showNotification3(DateTime timefornoti) async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID 3",
      "wesdok 3",
      "This is my channel 3",
      importance: Importance.max,
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    final time = await configureLocalTimeZone(timefornoti);

    await fltrNotification.zonedSchedule(
      2,
      'Daily Question 3',
      'click here to see question',
      time,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  Future _showNotification4(DateTime timefornoti) async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID 4",
      "wesdok 4",
      "This is my channel 4",
      importance: Importance.max,
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    final time = await configureLocalTimeZone(timefornoti);

    await fltrNotification.zonedSchedule(
      3,
      'Daily Question 4',
      'click here to see question',
      time,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  Future _showNotification5(DateTime timefornoti) async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID 5",
      "wesdok 5",
      "This is my channel 5",
      importance: Importance.max,
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    final time = await configureLocalTimeZone(timefornoti);

    await fltrNotification.zonedSchedule(
      4,
      'Daily Question 5',
      'click here to see question',
      time,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  Future _showNotification6(DateTime timefornoti) async {
    var androidDetails = new AndroidNotificationDetails(
      "Channel ID 6",
      "wesdok 6",
      "This is my channel 6",
      importance: Importance.max,
    );
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    final time = await configureLocalTimeZone(timefornoti);

    await fltrNotification.zonedSchedule(
      5,
      'Daily Question 6',
      'click here to see question',
      time,
      generalNotificationDetails,
      androidAllowWhileIdle: true,
    );
  }

  setNotifications() {
    if (DateTime.now()
        .isBefore(particularTime(DateTime.now(), '06:00:00.00'))) {
      _showNotification1(particularTime(DateTime.now(), '06:00:00.00'));
      print(
          'Notification 1 setted on ${particularTime(DateTime.now(), '06:00:00.00')}');
    } else {
      _showNotification1(
          particularTime(DateTime.now().add(Duration(days: 1)), '06:00:00.00'));
      print(
          'Notification 1 setted on ${particularTime(DateTime.now().add(Duration(days: 1)), '06:00:00.00')}');
    }
    //Notification 2-------------------------------------------------------------------

    if (DateTime.now()
        .isBefore(particularTime(DateTime.now(), '09:00:00.00'))) {
      _showNotification2(particularTime(DateTime.now(), '09:00:00.00'));
      print(
          'Notification 2 setted on ${particularTime(DateTime.now(), '09:00:00.00')}');
    } else {
      _showNotification2(
          particularTime(DateTime.now().add(Duration(days: 1)), '09:00:00.00'));
      print(
          'Notification 2 setted on ${particularTime(DateTime.now().add(Duration(days: 1)), '09:00:00.00')}');
    }

    //Notification 3-------------------------------------------------------------------

    if (DateTime.now()
        .isBefore(particularTime(DateTime.now(), '12:01:00.00'))) {
      _showNotification3(particularTime(DateTime.now(), '12:00:22.00'));
      print(
          'Notification 3 setted on ${particularTime(DateTime.now(), '12:00:22.00')}');
    } else {
      _showNotification3(
          particularTime(DateTime.now().add(Duration(days: 1)), '12:00:20.00'));
      print(
          'Notification 3 setted on ${particularTime(DateTime.now().add(Duration(days: 1)), '12:00:20.00')}');
    }

    //Notification 4-------------------------------------------------------------------

    if (DateTime.now()
        .isBefore(particularTime(DateTime.now(), '15:00:00.00'))) {
      _showNotification4(particularTime(DateTime.now(), '15:00:00.00'));
      print(
          'Notification 4 setted on ${particularTime(DateTime.now(), '15:00:00.00')}');
    } else {
      _showNotification4(
          particularTime(DateTime.now().add(Duration(days: 1)), '15:00:00.00'));
      print(
          'Notification 4 setted on ${particularTime(DateTime.now().add(Duration(days: 1)), '15:00:00.00')}');
    }

    //Notification 5-------------------------------------------------------------------

    if (DateTime.now()
        .isBefore(particularTime(DateTime.now(), '18:00:00.00'))) {
      _showNotification5(particularTime(DateTime.now(), '18:00:00.00'));
      print(
          'Notification 5 setted on ${particularTime(DateTime.now(), '18:00:00.00')}');
    } else {
      _showNotification5(
          particularTime(DateTime.now().add(Duration(days: 1)), '18:00:00.00'));
      print(
          'Notification 5 setted on ${particularTime(DateTime.now().add(Duration(days: 1)), '18:00:00.00')}');
    }

    //Notification 6-------------------------------------------------------------------

    if (DateTime.now()
        .isBefore(particularTime(DateTime.now(), '21:00:00.00'))) {
      _showNotification6(particularTime(DateTime.now(), '21:00:00.00'));
      print(
          'Notification 6 setted on ${particularTime(DateTime.now(), '21:00:00.00')}');
    } else {
      _showNotification6(
          particularTime(DateTime.now().add(Duration(days: 1)), '21:00:00.00'));
      print(
          'Notification 6 setted on ${particularTime(DateTime.now().add(Duration(days: 1)), '21:00:00.00')}');
    }
  }

  @override
  void initState() {
    var androidInitilize = AndroidInitializationSettings('logo');
    var iOSinitilize = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(
      initilizationsSettings,
      onSelectNotification: notificationSelected,
    );
    setNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ScreenChangeProvider>(context, listen: false)
        .setPageController(_pageController);
    selectedIndex = Provider.of<ScreenChangeProvider>(context).getScreenIndex();

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            Provider.of<ScreenChangeProvider>(context).getScreenIndex(),
        onTap: (index) {
          Provider.of<ScreenChangeProvider>(context, listen: false)
              .changeScreenIndex(index);
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
                FontAwesomeIcons.whatsapp,
              ),
              label: 'Whatapp'),
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
          NotificationScreen(),
          WhatAppScree(),
        ],
      ),
    );
  }
}
