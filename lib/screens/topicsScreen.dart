import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/models/topicModel.dart';
import 'package:ugc_net_notes/models/unitModel.dart';
import 'package:ugc_net_notes/screens/cardsScreen.dart';

class TopicsScreen extends StatefulWidget {
  final UnitModel unitModel;

  const TopicsScreen({this.unitModel});
  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  bool isLoading = false;
  final user = FirebaseAuth.instance.currentUser;

  List<TopicModel> finalTopics = [];
  int topicsDone = -1;

  resetScreen() {
    topicsDone = 0;
    finalTopics = [];
    fetchTopicsAndStatus();
  }

  fetchTopicsAndStatus() async {
    setState(() {
      isLoading = true;
    });

    final allTopics = await FirebaseFirestore.instance
        .collection('CourseTopicsContent')
        .doc(widget.unitModel.courseId)
        .collection('TopicsByunits')
        .doc(widget.unitModel.unitId)
        .collection('allTopics')
        .orderBy('topicId')
        .get();

    if (allTopics.docs.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    allTopics.docs.forEach((element) async {
      final topicStatus = await FirebaseFirestore.instance
          .collection('UserTopicsProgress')
          .doc(user.uid)
          .collection('courseEnrolled')
          .doc(widget.unitModel.courseId)
          .collection('allUnits')
          .doc(widget.unitModel.unitId)
          .collection('topicsDone')
          .doc(element.data()['topicId'])
          .get();

      final topic = TopicModel();

      topic.courseId = element.data()['courseId'];
      topic.topicName = element.data()['topicName'];
      topic.unitId = element.data()['unitId'];
      topic.topicId = element.data()['topicId'];
      topic.numberOfCards = element.data()['numberOfCards'];

      if (!topicStatus.exists) {
        topic.isTopicCompleted = false;
      } else {
        topic.isTopicCompleted = topicStatus.data()['isDone'];
      }
      finalTopics.add(topic);

      print(finalTopics.length);

      int tDone = 0;

      finalTopics.forEach((element) {
        if (element.isTopicCompleted) {
          tDone++;
        }
        setState(() {
          topicsDone = tDone;
        });
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  updateUnitStatus() async {
    if (widget.unitModel.isUnitCompleted == false) {
      await FirebaseFirestore.instance
          .collection('UserUnitsProgress')
          .doc(user.uid)
          .collection('courseEnrolled')
          .doc(widget.unitModel.courseId)
          .collection('unitsDone')
          .doc(widget.unitModel.unitId)
          .set({'isDone': true, 'topicId': widget.unitModel.unitId});
    }
    return;
  }

  increamentUnitsCount() async {
    if (widget.unitModel.isUnitCompleted == true) {
      return;
    }

    final currentProgressPath = FirebaseFirestore.instance
        .collection('UserCoursesProgress')
        .doc(user.uid)
        .collection('CoursesEnrolled')
        .doc(widget.unitModel.courseId);

    final currentProgress = await currentProgressPath.get();

    int currentUnitsDone = int.parse(currentProgress.data()['unitsDone']);

    await currentProgressPath
        .update({'unitsDone': (currentUnitsDone + 1).toString()});
  }

  @override
  void initState() {
    fetchTopicsAndStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unitModel.unitName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.circular(
                  5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
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
                      'TOPICS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
              ],
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
                        itemCount: finalTopics.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                        itemBuilder: (context, index) {
                          return TopicTile(
                            topicModel: finalTopics.firstWhere((element) =>
                                int.parse(element.topicId) == index + 1),
                            index: index,
                            resetScreen: resetScreen,
                          );
                        }),
                  ),
            if (topicsDone == finalTopics.length)
              GestureDetector(
                onTap: () async {
                  await updateUnitStatus();
                  await increamentUnitsCount();
                  Navigator.of(context).pop(true);
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    'Finish Unit',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
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
                : FAProgressBar(
                    displayText: '%',
                    currentValue: (topicsDone != 0 && topicsDone > 0)
                        ? (topicsDone / (finalTopics.length) * 100).toInt()
                        : 0,
                    progressColor: Colors.amber,
                  )
          ],
        ),
      ),
    );
  }
}

class TopicTile extends StatefulWidget {
  final TopicModel topicModel;
  final int index;
  final Function resetScreen;

  const TopicTile({this.topicModel, this.index, this.resetScreen});

  @override
  _TopicTileState createState() => _TopicTileState();
}

class _TopicTileState extends State<TopicTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardsScreen(
              topicModel: widget.topicModel,
            ),
          ),
        );
        if (result == true) {
          widget.resetScreen();
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: widget.topicModel.isTopicCompleted
                ? Color(0xffFBB782).withOpacity(0.7)
                : Color(0xffFBB782),
            border: Border.all(color: Color(0xffFA9A50))),
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
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Text(
                        widget.topicModel.topicName,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Container(
                    child: widget.topicModel.isTopicCompleted
                        ? Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 20,
                                    child: Image.asset('assets/greenTick.png'),
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
                            color: AppColors.primary,
                            size: 28,
                          ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.topicModel.numberOfCards}  Cards',
                            style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '  /  ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            widget.topicModel.isTopicCompleted
                                ? 'Re Read'
                                : 'Read',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
