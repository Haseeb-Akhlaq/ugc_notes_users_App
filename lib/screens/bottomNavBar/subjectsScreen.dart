import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/models/courseModel.dart';
import 'package:ugc_net_notes/widgets/drawer.dart';

class SubjectsScreen extends StatefulWidget {
  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  bool isLoading = false;

  enrollCourse(String courseId) async {
    setState(() {
      isLoading = true;
    });

    final userId = FirebaseAuth.instance.currentUser.uid;

    final enrollNewCoursePath = FirebaseFirestore.instance
        .collection('UserCoursesProgress')
        .doc(userId)
        .collection('CoursesEnrolled')
        .doc(courseId);

    final course = await enrollNewCoursePath.get();

    if (course.exists) {
      print('Course Already Enrolled');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Course Already Enrolled',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    await enrollNewCoursePath.set({
      'courseId': courseId,
      'cardsDone': '0',
      'topicsDone': '0',
      'unitsDone': '0'
    });

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'totalCoursesEnrolled': FieldValue.increment(1),
    });
    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Course SuccessFully Enrolled',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }

  getAllCourses() async {
    final allResults =
        await FirebaseFirestore.instance.collection('AllCourses').get();
    return allResults.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ScreenDrawer(),
      appBar: AppBar(
        title: Text('Search Courses'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CoursesSearch(courseEnroll: enrollCourse),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: getAllCourses(),
          builder: (context, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final results = futureSnapshot.data;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Container(
                              width: 70,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        results[index]['coursePic']),
                                    radius: 20,
                                  ),
                                  SizedBox(width: 10),
                                  Text('${results[index]['courseCode']}:'),
                                ],
                              ),
                            ),
                            title: Text(results[index]['courseName']),
                            trailing: GestureDetector(
                              onTap: () {
                                enrollCourse(results[index]['courseId']);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.yellow,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'Click To Enroll',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}

class CoursesSearch extends SearchDelegate<String> {
  final Function courseEnroll;
  CoursesSearch({this.courseEnroll});

  List<CourseModel> results = [];

  Future<List> searchResults(String query) async {
    if (query.isEmpty) {
      final allResults =
          await FirebaseFirestore.instance.collection('AllCourses').get();

      return allResults.docs;
    }

    final queryResultsByCode = await FirebaseFirestore.instance
        .collection('AllCourses')
        .where("courseCode", isEqualTo: query)
        .get();

    final queryResultsByName = await FirebaseFirestore.instance
        .collection('AllCourses')
        .where("nameParameters", arrayContains: query)
        .get();

    return [...queryResultsByCode.docs, ...queryResultsByName.docs];
  }

  List<CourseModel> recentList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {}

  @override
  Widget buildSuggestions(BuildContext context) {
    // List<CourseModel> suggestionList =
    //     query.isEmpty ? recentList : searchResults(query);

    return FutureBuilder(
        future: searchResults(query),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final results = futureSnapshot.data;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          minLeadingWidth: 0,
                          leading: Container(
                            width: 80,
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(results[index]['coursePic']),
                                  radius: 20,
                                ),
                                SizedBox(width: 20),
                                Text('${results[index]['courseCode']}:'),
                              ],
                            ),
                          ),
                          title: Text(results[index]['courseName']),
                          trailing: GestureDetector(
                            onTap: () {
                              courseEnroll(results[index]['courseId']);
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  'Click To Enroll',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
