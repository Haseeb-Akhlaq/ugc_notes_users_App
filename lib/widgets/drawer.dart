import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:ugc_net_notes/providers/ScreenChangeProvider.dart';
import 'package:ugc_net_notes/screens/contactUsScreen.dart';
import 'package:ugc_net_notes/screens/drawerScreens/privacyPolicyScreen.dart';
import 'package:ugc_net_notes/screens/drawerScreens/termsAndConditionsScreen.dart';

class ScreenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenProvider =
        Provider.of<ScreenChangeProvider>(context, listen: false);
    screenProvider.getValidityDays();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100,
            child: DrawerHeader(
              padding: EdgeInsets.only(top: 25, left: 30),
              child: Text(
                'UGC NOTES',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              screenProvider.changeScreenIndex(0);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.black,
            ),
            title: Row(
              children: [
                Text(
                  'Profile  ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '(${Provider.of<ScreenChangeProvider>(context).validityDays} Days Left)',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onTap: () {
              screenProvider.changeScreenIndex(2);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.book,
              color: Colors.black,
            ),
            title: Text(
              'Subjects',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              screenProvider.changeScreenIndex(1);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
            title: Text(
              'Notifications.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              screenProvider.changeScreenIndex(3);
              Navigator.pop(context);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.privacy_tip_outlined,
              color: Colors.black,
            ),
            title: Text(
              'Privacy Policy.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PrivacyPolicy(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.article,
              color: Colors.black,
            ),
            title: Text(
              'Terms and Conditions.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TermsCondition(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.share,
              color: Colors.black,
            ),
            title: Text(
              'Share app.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Share.share('check out UGC Notes app https:applink.com  ',
                  subject: 'Best app!');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.black,
            ),
            title: Text(
              'Contact Us.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactUs(),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.domain_verification,
              color: Colors.black,
            ),
            title: Text(
              'Version number',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {},
          ),
          Divider(),
        ],
      ),
    );
  }
}
