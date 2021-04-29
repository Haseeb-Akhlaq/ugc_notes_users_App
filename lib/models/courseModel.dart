class CourseModel {
  String courseId;
  String courseName;
  String numberOfUnitsLeft;
  String numberOfTopicsLeft;
  String numberOfCardsLeft;
  String daysLeftToExams;
  String totalUnits;
  String totalTopics;
  String totalCards;

  CourseModel(
      {this.courseId,
      this.courseName,
      this.daysLeftToExams,
      this.numberOfCardsLeft,
      this.numberOfTopicsLeft,
      this.numberOfUnitsLeft,
      this.totalCards,
      this.totalTopics,
      this.totalUnits});

  CourseModel.fromMap(Map<dynamic, dynamic> map) {
    this.courseId = map['courseId'];
    this.courseName = map['unitName'] ?? '';
    this.daysLeftToExams = map['daysLeftToExams'] ?? '';
    this.numberOfCardsLeft =
        (int.parse(map['totalCards']) - int.parse('cardsDone')).toString();
    this.numberOfTopicsLeft =
        (int.parse(map['totalTopics']) - int.parse('topicsDone')).toString();
    this.numberOfUnitsLeft =
        (int.parse(map['totalUnits']) - int.parse('unitsDone')).toString();
  }

  // Map<dynamic, dynamic> toJson() {
  //   return {
  //     'courseId': courseId,
  //     'courseName': courseName,
  //     'daysLeftToExams': daysLeftToExams,
  //     'numberOfCards': numberOfCards,
  //     'numberOfTopics': numberOfTopics,
  //     'numberOfUnits': numberOfUnits,
  //   };
  // }
}
