class UnitModel {
  String unitId;
  String unitName;
  String courseId;
  String numberOfTopics;
  String numberOfCards;
  bool isUnitCompleted;

  UnitModel(
      {this.courseId,
      this.unitId,
      this.numberOfCards,
      this.numberOfTopics,
      this.unitName,
      this.isUnitCompleted});
}
