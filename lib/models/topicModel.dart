class TopicModel {
  String topicId;
  String unitId;
  String courseId;

  String topicName;
  String numberOfCards;
  bool isTopicCompleted;

  TopicModel(
      {this.topicId,
      this.unitId,
      this.courseId,
      this.topicName,
      this.numberOfCards,
      this.isTopicCompleted});
}
