import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/models/courseModel.dart';
import 'package:ugc_net_notes/providers/ScreenChangeProvider.dart';
import 'package:ugc_net_notes/screens/unitsScreen.dart';
import 'package:ugc_net_notes/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  List<CourseModel> allEnrolledCoursed = [];
  bool isLoading = false;

  String getExamDate(String date) {
    final examDate = DateTime.parse(date);
    String examsLeftDays =
        examDate.difference(DateTime.now()).inDays.toString();
    return examsLeftDays;
  }

  getEnrolledCourses() async {
    setState(() {
      isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('UserCoursesProgress')
        .doc(user.uid)
        .collection('CoursesEnrolled')
        .snapshots()
        .listen((event) {
      if (event.docs.length == 0) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      event.docs.forEach((element) async {
        allEnrolledCoursed = [];

        final courseDetailsData = await FirebaseFirestore.instance
            .collection('AllCourses')
            .doc(element.data()['courseId'])
            .get();

        final enrolledCourse = CourseModel();

        enrolledCourse.coursePic = courseDetailsData.data()['coursePic'];
        enrolledCourse.courseId = courseDetailsData.data()['courseId'];
        enrolledCourse.courseName = courseDetailsData.data()['courseName'];
        enrolledCourse.daysLeftToExams =
            getExamDate(courseDetailsData.data()['examDate']);

        enrolledCourse.numberOfTopicsLeft =
            (int.parse(courseDetailsData.data()['totalTopics']) -
                    int.parse(element.data()['topicsDone']))
                .toString();

        enrolledCourse.numberOfCardsLeft =
            (int.parse(courseDetailsData.data()['totalCards']) -
                    int.parse(element.data()['cardsDone']))
                .toString();

        enrolledCourse.numberOfUnitsLeft =
            (int.parse(courseDetailsData.data()['totalUnits']) -
                    int.parse(element.data()['unitsDone']))
                .toString();

        enrolledCourse.totalUnits = courseDetailsData.data()['totalUnits'];
        enrolledCourse.totalTopics = courseDetailsData.data()['totalTopics'];
        enrolledCourse.totalCards = courseDetailsData.data()['totalCards'];
        enrolledCourse.courseCode = courseDetailsData.data()['courseCode'];

        print(enrolledCourse.totalCards);

        print(courseDetailsData.data());

        allEnrolledCoursed.add(enrolledCourse);

        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getEnrolledCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enrolled Subjects'),
        centerTitle: true,
      ),
      drawer: ScreenDrawer(),
      body: isLoading
          ? Center(
              child: SpinKitCircle(
                color: AppColors.primary,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
              child: Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (allEnrolledCoursed.length == 0)
                      Column(
                        children: [
                          Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Text(
                                      'Dear ${user.displayName}',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      'Start Reading',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              Provider.of<ScreenChangeProvider>(context,
                                      listen: false)
                                  .changeScreenIndex(1);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                'Click To Add Courses',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    Expanded(
                      child: Scrollbar(
                        isAlwaysShown: true,
                        showTrackOnHover: true,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount: allEnrolledCoursed.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    if (index == 0)
                                      Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Dear ${user.displayName}',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Text(
                                                  'Start Reading',
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (index == 0) SizedBox(height: 30),
                                    CourseCard(
                                      courseModel: allEnrolledCoursed[index],
                                      index: index,
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final CourseModel courseModel;
  final int index;

  const CourseCard({this.courseModel, this.index});
  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  int getBarProgress() {
    int unitsLeft = int.parse(widget.courseModel.numberOfUnitsLeft);
    int totalUnits = int.parse(widget.courseModel.totalUnits);

    if (totalUnits == 0) {
      return 0;
    }

    int progress = (((totalUnits - unitsLeft) / totalUnits) * 100).toInt();
    return progress;
  }

  double getCourseNameFontSize(String name) {
    if (name.length < 18) {
      return 18;
    }

    if (name.length > 18 && name.length < 27) {
      return 15;
    }

    if (name.length > 27) {
      return 14;
    }
    return 12;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  minLeadingWidth: 0,
                  leading: Container(
                    width: 70,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(widget.courseModel.coursePic),
                        ),
                        SizedBox(width: 10),
                        Text('${widget.courseModel.courseCode}:')
                      ],
                    ),
                  ),
                  title: Text(
                    widget.courseModel.courseName,
                    style: TextStyle(
                        fontSize: getCourseNameFontSize(
                            widget.courseModel.courseName)),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnitsScreen(
                            courseModel: widget.courseModel,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 130,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.courseModel.daysLeftToExams,
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  'Day left To Exams',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 130,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.courseModel.numberOfTopicsLeft,
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  'Topics Left',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Container(
                      width: 130,
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.courseModel.numberOfCardsLeft,
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(
                                  'Cards left',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FAProgressBar(
                displayTextStyle: TextStyle(
                  color: Colors.black,
                ),
                progressColor: Colors.amber,
                currentValue: getBarProgress(),
                displayText: '%',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
