import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/models/courseModel.dart';
import 'package:ugc_net_notes/screens/unitsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  List<CourseModel> allEnrolledCoursed = [];
  bool isLoading = false;

  getEnrolledCourses() async {
    setState(() {
      isLoading = true;
    });
    final coursesEnrolled = await FirebaseFirestore.instance
        .collection('UserCoursesProgress')
        .doc(user.uid)
        .collection('CoursesEnrolled')
        .get();

    coursesEnrolled.docs.forEach((element) async {
      print(element.data());

      final courseDetailsData = await FirebaseFirestore.instance
          .collection('AllCourses')
          .doc(element.data()['courseId'])
          .get();

      final enrolledCourse = CourseModel();

      enrolledCourse.courseId = courseDetailsData.data()['courseId'];
      enrolledCourse.courseName = courseDetailsData.data()['courseName'];
      enrolledCourse.daysLeftToExams = courseDetailsData.data()['examIn'];

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

      print(enrolledCourse.totalCards);

      print(courseDetailsData.data());

      allEnrolledCoursed.add(enrolledCourse);

      setState(() {
        isLoading = false;
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
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
              ),
              isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: AppColors.primary,
                      ),
                    )
                  : Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: allEnrolledCoursed.length,
                          itemBuilder: (context, index) {
                            return CourseCard(
                              courseModel: allEnrolledCoursed[index],
                              index: index,
                            );
                          }),
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
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.u-bordeaux.com/var/ezdemo_site/storage/images/media/working/international-masters/economic-affairs/364177-1-eng-GB/Economic-Affairs_Grande.jpg'),
                  ),
                  Text('${widget.index + 1} .'),
                  Text(
                    widget.courseModel.courseName,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnitsScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 30,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      width: 150,
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
                                Text('Day left To Exams')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 150,
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
                                Text('Topics Left')
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      width: 150,
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
                                Text('Cards left')
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
                currentValue:
                    (int.parse(widget.courseModel.numberOfUnitsLeft) ~/
                            int.parse(widget.courseModel.totalUnits == '0'
                                ? '1'
                                : widget.courseModel.totalUnits))
                        .toInt(),
                displayText: '%',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
