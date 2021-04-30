import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  List<CardModel> finalCards = [];
  int cardsDone = -1;

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

      card.courseId = widget.topicModel.courseId;
      card.cardContent = element.data()['cardContent'];
      card.unitId = widget.topicModel.unitId;
      card.topicId = widget.topicModel.topicId;
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
    if (widget.topicModel.isTopicCompleted == false) {
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
    if (widget.topicModel.isTopicCompleted == true) {
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
    fetchAllCards();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topicModel.topicName),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            FAProgressBar(
              displayText: '%',
              currentValue: cardsDone != 0 && cardsDone > 0
                  ? (cardsDone / (finalCards.length) * 100).toInt()
                  : 0,
              progressColor: Colors.amber,
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
                        itemCount: finalCards.length,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 60);
                        },
                        itemBuilder: (context, index) {
                          return CardTile(
                            cardModel: finalCards.firstWhere((element) =>
                                int.parse(element.cardId) == index + 1),
                            index: index,
                            totalCards: finalCards.length,
                            cardsDone: updateCardsDone,
                          );
                        }),
                  ),
            SizedBox(
              height: 10,
            ),
            if (cardsDone == finalCards.length)
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
                    border: Border.all(color: Colors.black),
                  ),
                  child: Text(
                    'Finish Reading',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              )
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

  const CardTile({this.cardModel, this.index, this.totalCards, this.cardsDone});
  @override
  _CardTileState createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  final user = FirebaseAuth.instance.currentUser;

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: Text('${widget.index + 1} / ${widget.totalCards}'),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.cardModel.cardContent,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'Done This Cards',
                    style: TextStyle(fontSize: 10),
                  ),
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
            )
          ],
        ),
      ),
    );
  }
}
