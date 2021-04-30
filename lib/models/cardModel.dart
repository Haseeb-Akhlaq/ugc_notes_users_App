class CardModel {
  String cardId;
  String topicId;
  String unitId;
  String courseId;
  String cardContent;
  bool isDone;

  CardModel(
      {this.unitId,
      this.topicId,
      this.courseId,
      this.cardContent,
      this.cardId,
      this.isDone});
}
