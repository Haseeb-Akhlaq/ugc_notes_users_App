class CardModel {
  String cardId;
  String topicId;
  String unitId;
  String courseId;

  String cardHeading1;
  String cardContent1;
  String cardHeading2;
  String cardContent2;

  String cardPic;

  bool isDone;

  CardModel(
      {this.unitId,
      this.topicId,
      this.courseId,
      this.cardHeading1,
      this.cardContent1,
      this.cardHeading2,
      this.cardContent2,
      this.cardPic,
      this.cardId,
      this.isDone});
}
