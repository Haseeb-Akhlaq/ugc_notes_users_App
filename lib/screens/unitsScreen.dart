import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/models/courseModel.dart';
import 'package:ugc_net_notes/models/unitModel.dart';
import 'package:ugc_net_notes/screens/paymentScreen.dart';
import 'package:ugc_net_notes/screens/topicsScreen.dart';

class UnitsScreen extends StatefulWidget {
  final CourseModel courseModel;

  const UnitsScreen({this.courseModel});
  @override
  _UnitsScreenState createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  final user = FirebaseAuth.instance.currentUser;

  List<UnitModel> finalUnits = [];
  bool isLoading = false;

  bool isUserPremium = false;

  checkUserPremium() async {
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    setState(() {
      isUserPremium = userData.data()['premiumUser'];
    });
  }

  resetScreen() {
    finalUnits = [];
    checkUserPremium();
    fetchAllUnitsAndStatus();
  }

  fetchAllUnitsAndStatus() async {
    setState(() {
      isLoading = true;
    });

    final allUnits = await FirebaseFirestore.instance
        .collection('CourseUnitsContent')
        .doc(widget.courseModel.courseId)
        .collection('AllUnitsContent')
        .orderBy('unitId')
        .get();

    if (allUnits.docs.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    allUnits.docs.forEach((element) async {
      print('-------------------------firset');
      print(element.data());
      print('-------------------------firset');
      final unitStatus = await FirebaseFirestore.instance
          .collection('UserUnitsProgress')
          .doc(user.uid)
          .collection('courseEnrolled')
          .doc(widget.courseModel.courseId)
          .collection('unitsDone')
          .doc(element.data()['unitId'])
          .get();

      final courseUnit = UnitModel();

      courseUnit.courseId = element.data()['courseId'];
      courseUnit.unitName = element.data()['unitName'];
      courseUnit.unitId = element.data()['unitId'];
      courseUnit.numberOfTopics = element.data()['numberOfTopics'];
      courseUnit.numberOfCards = element.data()['numberOfCards'];

      if (!unitStatus.exists) {
        courseUnit.isUnitCompleted = false;
      } else {
        courseUnit.isUnitCompleted = unitStatus.data()['isDone'];
      }
      finalUnits.add(courseUnit);
      print(finalUnits[0].unitName);

      setState(() {
        isLoading = false;
      });
    });
  }

  int getProgressBarValue() {
    int unitsLeft = int.parse(widget.courseModel.numberOfUnitsLeft);
    int totalUnits = int.parse(widget.courseModel.totalUnits);

    print('--------------------------');
    print(totalUnits);
    print(unitsLeft);
    print('--------------------------');

    if (totalUnits == 0) {
      return 0;
    }
    int progressValue = (((totalUnits - unitsLeft) / totalUnits) * 100).toInt();

    return progressValue;
  }

  @override
  void initState() {
    checkUserPremium();
    fetchAllUnitsAndStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30,
                    child: Image.network(
                        'https://www.u-bordeaux.com/var/ezdemo_site/storage/images/media/working/international-masters/economic-affairs/364177-1-eng-GB/Economic-Affairs_Grande.jpg'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.courseModel.courseName,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(
                  10,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.courseModel.totalTopics} Topics',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '  /  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${widget.courseModel.totalCards} Cards',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: 150,
                    child: Card(
                      elevation: 4,
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
                      elevation: 4,
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
                      elevation: 4,
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
            isLoading
                ? Center(
                    child: SpinKitChasingDots(
                      color: AppColors.primary,
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        if (index == 0 && isUserPremium == false) {
                          return GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(),
                                ),
                              );

                              if (result == true) {
                                resetScreen();
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffFBB782)),
                                color: Color(0xffFBB782).withOpacity(0.7),
                              ),
                              child: Text(
                                'Click here & unlock all units Notes ',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        }
                        return SizedBox(height: 10);
                      },
                      itemCount: finalUnits.length,
                      itemBuilder: (context, index) {
                        return UnitTile(
                          unitModel: finalUnits.firstWhere((element) =>
                              int.parse(element.unitId) == index + 1),
                          index: index,
                          reset: resetScreen,
                          userPremium: isUserPremium,
                        );
                      },
                    ),
                  ),
            FAProgressBar(
              progressColor: Colors.amber,
              currentValue: getProgressBarValue(),
              displayText: '%',
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                  width: 120,
                  color: Colors.white,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Text(
                            'Need Help ?  ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Container(
                            width: 20,
                            child: Image.asset('assets/whatsapp.png'),
                          ),
                        ],
                      ),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class UnitTile extends StatefulWidget {
  final UnitModel unitModel;
  final int index;
  final Function reset;
  final bool userPremium;

  const UnitTile({this.unitModel, this.index, this.reset, this.userPremium});
  @override
  _UnitTileState createState() => _UnitTileState();
}

class _UnitTileState extends State<UnitTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.index > 0 && widget.userPremium == false) {
          return;
        }
        final results = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopicsScreen(
              unitModel: widget.unitModel,
            ),
          ),
        );
        if (results == true) {
          widget.reset();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primary, border: Border.all(color: Colors.black)),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '${(widget.index + 1)} .',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        widget.unitModel.unitName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Container(
                      child: widget.unitModel.isUnitCompleted
                          ? Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 20,
                                      child:
                                          Image.asset('assets/greenTick.png'),
                                    ),
                                    Text(
                                      'Completed',
                                      style: TextStyle(fontSize: 8),
                                    ),
                                  ],
                                ),
                              ))
                          : Icon(
                              Icons.arrow_forward,
                              color: AppColors.yellow,
                              size: 28,
                            ))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.unitModel.numberOfTopics} Topics',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '  /  ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${widget.unitModel.numberOfCards} Cards',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.index == 0 && widget.userPremium == false)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Free',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  if (widget.index > 0 && widget.userPremium == false)
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(),
                          ),
                        );

                        if (result == true) {
                          widget.reset();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.lock),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
