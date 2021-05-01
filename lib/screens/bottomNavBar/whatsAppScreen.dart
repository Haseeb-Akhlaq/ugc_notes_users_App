import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class WhatsAppScreen extends StatefulWidget {
  @override
  _WhatsAppScreenState createState() => _WhatsAppScreenState();
}

class _WhatsAppScreenState extends State<WhatsAppScreen> {
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+92-331 5901231',
      text: "Hey! I need help regarding UGC notes app",
    );
    await launch('$link');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            launchWhatsApp();
          },
          child: Container(
              width: 250,
              color: Colors.white,
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        'Support ',
                        style: TextStyle(fontSize: 35),
                      ),
                      Container(
                        width: 50,
                        child: Image.asset('assets/whatsapp.png'),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
