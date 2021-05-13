import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:ugc_net_notes/constants/colors.dart';
import 'package:ugc_net_notes/models/cardModel.dart';
import 'package:ugc_net_notes/models/topicModel.dart';

class CardsScreen extends StatefulWidget {
  final TopicModel topicModel;

  const CardsScreen({this.topicModel});

  @override
  _CardsScreenState createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  bool isLoading = false;
  final user = FirebaseAuth.instance.currentUser;
  final ScrollController _scrollController = ScrollController();

  List<CardModel> finalCards = [];
  int cardsDone = -1;

  bool isDarkMode = false;
  double fontSize = 0;

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  updateCardsDone(bool value) {
    if (value) {
      setState(() {
        cardsDone++;
      });
    } else if (value == false) {
      setState(() {
        cardsDone--;
      });
    }
  }

  fetchAllCards() async {
    setState(() {
      isLoading = true;
    });

    final allCards = await FirebaseFirestore.instance
        .collection('CourseCardsContent')
        .doc(widget.topicModel.courseId)
        .collection('CardsByUnits')
        .doc(widget.topicModel.unitId)
        .collection('CardsByTopic')
        .doc(widget.topicModel.topicId)
        .collection('AllCards')
        .orderBy('cardId')
        .get();

    if (allCards.docs.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    allCards.docs.forEach((element) async {
      final cardStatus = await FirebaseFirestore.instance
          .collection('UserCardsProgress')
          .doc(user.uid)
          .collection('courseEnrolled')
          .doc(widget.topicModel.courseId)
          .collection('allUnits')
          .doc(widget.topicModel.unitId)
          .collection('allTopics')
          .doc(widget.topicModel.topicId)
          .collection('cardsDone')
          .doc(element.data()['cardId'])
          .get();

      final card = CardModel();

      card.unitId = widget.topicModel.unitId;
      card.topicId = widget.topicModel.topicId;
      card.courseId = widget.topicModel.courseId;
      card.cardContent = element.data()['CARD'];

      card.cardId = element.data()['cardId'];

      if (!cardStatus.exists) {
        card.isDone = false;
      } else {
        card.isDone = cardStatus.data()['isDone'];
      }
      finalCards.add(card);

      print(finalCards.length);
      int cDone = 0;
      finalCards.forEach((element) {
        if (element.isDone) {
          cDone++;
        }
        setState(() {
          cardsDone = cDone;
        });
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  updateTopicStatus() async {
    print('$cardsDone--------cards done');
    print('${finalCards.length}--------cards length');
    if (widget.topicModel.isTopicCompleted == false &&
        cardsDone == finalCards.length) {
      print('here');
      await FirebaseFirestore.instance
          .collection('UserTopicsProgress')
          .doc(user.uid)
          .collection('courseEnrolled')
          .doc(widget.topicModel.courseId)
          .collection('allUnits')
          .doc(widget.topicModel.unitId)
          .collection('topicsDone')
          .doc(widget.topicModel.topicId)
          .set({'isDone': true, 'topicId': widget.topicModel.topicId});
    }
    return;
  }

  increamentTopicsCount() async {
    if (widget.topicModel.isTopicCompleted == true ||
        cardsDone != finalCards.length) {
      print('here');
      return;
    }

    final currentProgressPath = FirebaseFirestore.instance
        .collection('UserCoursesProgress')
        .doc(user.uid)
        .collection('CoursesEnrolled')
        .doc(widget.topicModel.courseId);

    final currentProgress = await currentProgressPath.get();

    int currentCardsDone = int.parse(currentProgress.data()['topicsDone']);

    await currentProgressPath
        .update({'topicsDone': (currentCardsDone + 1).toString()});
  }

  @override
  void initState() {
    secureScreen();
    fetchAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        title: Text(widget.topicModel.topicName),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 15.0, right: 15, left: 15, bottom: 2),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: FAProgressBar(
                      displayText: '%',
                      displayTextStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      currentValue: cardsDone != 0 && cardsDone > 0
                          ? (cardsDone / (finalCards.length) * 100).toInt()
                          : 0,
                      progressColor: Colors.amber,
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Container(
                  width: 70,
                  padding: EdgeInsets.only(bottom: 10),
                  child: Stack(
                    children: [
                      Positioned(
                          left: 0,
                          top: 15,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'A',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Text(
                                'A ',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                              )
                            ],
                          )),
                      SliderTheme(
                        data: SliderThemeData(
                          minThumbSeparation: 0,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 7),
                        ),
                        child: Container(
                          width: 70,
                          child: Slider(
                              value: fontSize,
                              min: 0,
                              max: 5,
                              divisions: 5,
                              label: '$fontSize',
                              activeColor:
                                  isDarkMode ? Colors.white : Colors.black,
                              inactiveColor:
                                  isDarkMode ? Colors.white : Colors.black,
                              onChanged: (v) {
                                setState(() {
                                  fontSize = v;
                                  print(v);
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  height: 60,
                  width: 50,
                  child: Column(
                    children: [
                      Switch(
                          activeColor: Colors.white,
                          inactiveThumbColor: Colors.black,
                          activeThumbImage: AssetImage('assets/greenTick.png'),
                          value: isDarkMode,
                          onChanged: (v) {
                            setState(() {
                              isDarkMode = v;
                              print(isDarkMode);
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
            isLoading
                ? Center(
                    child: SpinKitChasingDots(
                      color: AppColors.primary,
                    ),
                  )
                : Expanded(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      showTrackOnHover: true,
                      child: Stack(
                        children: [
                          ListView.separated(
                              controller: _scrollController,
                              itemCount: finalCards.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 20);
                              },
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    CardTile(
                                      cardModel: finalCards.firstWhere(
                                          (element) =>
                                              int.parse(element.cardId) ==
                                              index + 1),
                                      index: index,
                                      totalCards: finalCards.length,
                                      cardsDone: updateCardsDone,
                                      isDarkMode: isDarkMode,
                                      fontSize: fontSize,
                                    ),
                                    if (index == finalCards.length - 1)
                                      SizedBox(height: 30),
                                    if (index == finalCards.length - 1)
                                      GestureDetector(
                                        onTap: () async {
                                          await updateTopicStatus();
                                          await increamentTopicsCount();
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            border:
                                                Border.all(color: Colors.black),
                                          ),
                                          child: Text(
                                            'Finish Reading',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    SizedBox(height: 30),
                                  ],
                                );
                              }),
                          Positioned(
                            bottom: 15,
                            left: 0,
                            child: GestureDetector(
                              onTap: () {
                                _scrollController.animateTo(
                                    _scrollController.position.minScrollExtent,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.2),
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.arrow_upward_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            // if (cardsDone == finalCards.length)
            //   GestureDetector(
            //     onTap: () async {
            //       await updateTopicStatus();
            //       await increamentTopicsCount();
            //       Navigator.of(context).pop(true);
            //     },
            //     child: Container(
            //       padding: EdgeInsets.all(5),
            //       decoration: BoxDecoration(
            //         color: AppColors.primary,
            //         border: Border.all(color: Colors.black),
            //       ),
            //       child: Text(
            //         'Finish Reading',
            //         style: TextStyle(color: Colors.white, fontSize: 16),
            //       ),
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}

class CardTile extends StatefulWidget {
  final CardModel cardModel;
  final int index;
  final int totalCards;
  final Function cardsDone;
  final bool isDarkMode;
  final double fontSize;

  const CardTile({
    this.cardModel,
    this.index,
    this.totalCards,
    this.cardsDone,
    this.isDarkMode,
    this.fontSize,
  });
  @override
  _CardTileState createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  final user = FirebaseAuth.instance.currentUser;

  FontSize getFontSize(double size) {
    if (size == 0.0) {
      return FontSize.smaller;
    }
    if (size == 1.0) {
      return FontSize.small;
    }
    if (size == 2.0) {
      return FontSize.medium;
    }
    if (size == 3.0) {
      return FontSize.large;
    }
    if (size == 4.0) {
      return FontSize.larger;
    }
    if (size == 5.0) {
      return FontSize.xLarge;
    }
    return FontSize.medium;
  }

  updateCardStatus(bool status) async {
    await FirebaseFirestore.instance
        .collection('UserCardsProgress')
        .doc(user.uid)
        .collection('courseEnrolled')
        .doc(widget.cardModel.courseId)
        .collection('allUnits')
        .doc(widget.cardModel.unitId)
        .collection('allTopics')
        .doc(widget.cardModel.topicId)
        .collection('cardsDone')
        .doc(widget.cardModel.cardId)
        .set({'isDone': status, 'cardId': widget.cardModel.cardId});
  }

  incrementCardsDone() async {
    final currentProgressPath = FirebaseFirestore.instance
        .collection('UserCoursesProgress')
        .doc(user.uid)
        .collection('CoursesEnrolled')
        .doc(widget.cardModel.courseId);

    final currentProgress = await currentProgressPath.get();

    int currentCardsDone = int.parse(currentProgress.data()['cardsDone']);

    await currentProgressPath
        .update({'cardsDone': (currentCardsDone + 1).toString()});
  }

  decrementCardsDone() async {
    final currentProgressPath = FirebaseFirestore.instance
        .collection('UserCoursesProgress')
        .doc(user.uid)
        .collection('CoursesEnrolled')
        .doc(widget.cardModel.courseId);

    final currentProgress = await currentProgressPath.get();

    int currentCardsDone = int.parse(currentProgress.data()['cardsDone']);

    await currentProgressPath
        .update({'cardsDone': (currentCardsDone - 1).toString()});
  }

  @override
  Widget build(BuildContext context) {
    final htmlData = widget.cardModel.cardContent;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shadowColor: widget.isDarkMode ? Colors.white : Colors.black,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDarkMode ? Colors.grey[900] : Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(
                    data: htmlData,
                    onImageError: (exception, stackTrace) {
                      print(exception);
                    },
                    style: {
                      'body': Style(
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                          fontSize: getFontSize(widget.fontSize)),
                    },
                    onLinkTap: (url, _, __, ___) {
                      print("Opening $url...");
                    },
                    onImageTap: (src, _, __, ___) {
                      print(src);
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      width: 40,
                      child: Text(
                        '${widget.index + 1} / ${widget.totalCards}',
                        style: TextStyle(
                          color:
                              widget.isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 90,
                      child: Column(
                        children: [
                          Text(
                            'Done This Cards',
                            style: TextStyle(
                              fontSize: 8,
                              color: widget.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            value: widget.cardModel.isDone,
                            onChanged: (v) {
                              setState(() {
                                widget.cardsDone(v);
                                widget.cardModel.isDone = v;
                              });

                              updateCardStatus(v);

                              if (v == true) {
                                incrementCardsDone();
                              }
                              if (v == false) {
                                decrementCardsDone();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
