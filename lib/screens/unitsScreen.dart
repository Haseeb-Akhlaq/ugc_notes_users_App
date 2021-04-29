import 'package:flutter/material.dart';
import 'package:ugc_net_notes/models/courseModel.dart';

class UnitsScreen extends StatefulWidget {
  final CourseModel courseModel;

  const UnitsScreen({this.courseModel});
  @override
  _UnitsScreenState createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
    );
  }
}
