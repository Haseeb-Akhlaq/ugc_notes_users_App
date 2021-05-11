import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ugc_net_notes/models/questionModel.dart';
import 'package:ugc_net_notes/models/userModel.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<QuestionModel> allQuestion = [];
  bool isLoading = false;
  AppUser loggedUser;

  int startingQuestionIndex = 0;
  int endingQuestionIndex = 0;

  DateTime particularTime(DateTime datefornoti, String timeInHours) {
    String todayDate = datefornoti.toString();
    String date = todayDate.split(' ')[0];
    date = '$date $timeInHours';
    final finalDate = DateTime.parse(date);
    return finalDate;
  }

  getUserDetails() async {
    final userId = FirebaseAuth.instance.currentUser.uid;

    print(userId);

    if (userId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    final user =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (!user.exists) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    loggedUser = AppUser.fromMap(user.data());
    print(loggedUser.joinedOn);
    checkQuestionRange();
    fetchQuestions();
    setState(() {
      isLoading = false;
    });
  }

  checkQuestionRange() {
    print(loggedUser.joinedOn);

    final diff =
        DateTime.now().difference(DateTime.parse(loggedUser.joinedOn)).inDays;
    print('diff');
    print(diff);

    startingQuestionIndex = (diff * 6) + 1;
    endingQuestionIndex = startingQuestionIndex + 5;

    if (DateTime.now()
        .isBefore(particularTime(DateTime.now(), '06:00:00.00'))) {
      endingQuestionIndex = startingQuestionIndex - 1;
    }

    if (DateTime.now().isAfter(particularTime(DateTime.now(), '06:00:00.00'))) {
      endingQuestionIndex = startingQuestionIndex;
    }
    if (DateTime.now().isAfter(particularTime(DateTime.now(), '09:00:00.00'))) {
      endingQuestionIndex = startingQuestionIndex + 1;
    }
    if (DateTime.now().isAfter(particularTime(DateTime.now(), '12:00:00.00'))) {
      endingQuestionIndex = startingQuestionIndex + 2;
    }
    if (DateTime.now().isAfter(particularTime(DateTime.now(), '15:00:00.00'))) {
      endingQuestionIndex = startingQuestionIndex + 3;
    }
    if (DateTime.now().isAfter(particularTime(DateTime.now(), '18:00:00.00'))) {
      endingQuestionIndex = startingQuestionIndex + 4;
    }
    if (DateTime.now().isAfter(particularTime(DateTime.now(), '21:00:00.00'))) {
      endingQuestionIndex = startingQuestionIndex + 5;
      print(endingQuestionIndex);
      print('HERE IT COMES FOR DATA');
    }
  }

  fetchQuestions() async {
    setState(() {
      isLoading = true;
    });
    final questions = await DefaultAssetBundle.of(context)
        .loadString("assets/json/testingQuestions.json");

    if (questions.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final qus = jsonDecode(questions);

    for (int i = startingQuestionIndex; i < endingQuestionIndex + 1; i++) {
      print(i);
      final q = QuestionModel.fromMap(qus['$i']);
      print(q.questionContent);
      setState(() {
        allQuestion.add(q);
      });
    }
  }

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        DateTime.now().toString().split(' ')[0],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Expanded(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      showTrackOnHover: true,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 20);
                            },
                            itemCount: allQuestion.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return QuestionCard(
                                questionModel: allQuestion[index],
                                index: index,
                              );
                            }),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class QuestionCard extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  const QuestionCard({this.questionModel, this.index});
  @override
  _QuestionCardState createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool isCorrectAnswer;

  showAnswer(String optionChosen, String correctAnswer) {
    print(optionChosen);
    print(correctAnswer);
    if (optionChosen.trim() == correctAnswer.trim()) {
      setState(() {
        isCorrectAnswer = true;
        print('ansewer is correct');
      });
    } else {
      setState(() {
        isCorrectAnswer = false;
        print('ansewer is wrong');
      });
    }
  }

  String getTime() {
    if (widget.index == 0) {
      return '6AM';
    }
    if (widget.index == 1) {
      return '9AM';
    }
    if (widget.index == 2) {
      return '12PM';
    }
    if (widget.index == 3) {
      return '3PM';
    }
    if (widget.index == 4) {
      return '6PM';
    }
    if (widget.index == 5) {
      return '9PM';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final htmlData = widget.questionModel.questionContent;
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height - 150,
      child: Card(
        elevation: 5,
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        getTime(),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Html(
                    data: htmlData,
                    onLinkTap: (url) {
                      print("Opening $url...");
                    },
                    onImageTap: (src) {
                      print(src);
                    },
                    onImageError: (exception, stackTrace) {
                      print(exception);
                    },
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showAnswer(widget.questionModel.option1.substring(1, 2),
                          widget.questionModel.correctAnswer);
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          'A  :  ${widget.questionModel.option1.substring(3)}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showAnswer(widget.questionModel.option2.substring(1, 2),
                          widget.questionModel.correctAnswer);
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          'B  :  ${widget.questionModel.option2.substring(3)}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showAnswer(widget.questionModel.option3.substring(1, 2),
                          widget.questionModel.correctAnswer);
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          'C  :  ${widget.questionModel.option3.substring(3)}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showAnswer(widget.questionModel.option4.substring(1, 2),
                          widget.questionModel.correctAnswer);
                    },
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text(
                          'D :  ${widget.questionModel.option4.substring(3)}',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (isCorrectAnswer != null)
                    Row(
                      children: [
                        Text(isCorrectAnswer
                            ? 'Answer is Correct'
                            : 'Answer is wrong'),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          isCorrectAnswer ? Icons.check : Icons.close,
                          color: isCorrectAnswer ? Colors.green : Colors.red,
                        )
                      ],
                    )
                ],
              )),
        ),
      ),
    );
  }
}
