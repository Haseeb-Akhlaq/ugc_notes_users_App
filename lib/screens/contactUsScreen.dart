import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextStyle _cardDetail = TextStyle(color: Colors.black, fontSize: 18);

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+91-6303 314 013',
      text: "Hey! I need help regarding UGC notes app",
    );
    await launch('$link');
  }

  Widget _contactInformation() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.phone,
                    size: 18,
                    color: Colors.black,
                  ),
                  title: Text(
                    '+91-6303 314 013',
                    style: _cardDetail,
                  ))),
          Container(
              width: double.infinity,
              child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.envelope,
                    size: 18,
                    color: Colors.red,
                  ),
                  title: Text(
                    'tests@ugcnetapp.in',
                    style: _cardDetail,
                  ))),
          GestureDetector(
            onTap: () {
              launchWhatsApp();
            },
            child: Container(
              width: double.infinity,
              child: ListTile(
                leading: Icon(
                  FontAwesomeIcons.whatsapp,
                  size: 18,
                  color: Colors.green,
                ),
                title: Text(
                  '+91-6303 314 013',
                  style: _cardDetail,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Contact us'),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                child: CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.green.shade50,
                  child: ClipOval(
                    child: Image(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/contact_us.png'),
                    ),
                  ),
                ),
              ),
              Head(),
              _contactInformation()
            ],
          ),
        ),
      ),
    );
  }
}

class Head extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: <Widget>[
          Text(
            'Contact Us',
            style: TextStyle(
                fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Text(
            '!',
            style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 50,
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
