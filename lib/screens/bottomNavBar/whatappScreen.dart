import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class WhatAppScree extends StatefulWidget {
  @override
  _WhatAppScreeState createState() => _WhatAppScreeState();
}

class _WhatAppScreeState extends State<WhatAppScree> {
  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+91-6303 314 013',
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
      body: GestureDetector(
        onTap: () {
          launchWhatsApp();
        },
        child: Center(
          child: Card(
            child: Container(
              width: 220,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    'Support   ',
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  Container(
                      height: 40, child: Image.asset('assets/whatsapp.png')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
