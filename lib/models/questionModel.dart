class QuestionModel {
  String questionContent;

  String option1;
  String option2;
  String option3;
  String option4;

  String correctAnswer;

  QuestionModel({
    this.correctAnswer,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.questionContent,
  });

  QuestionModel.fromMap(Map<dynamic, dynamic> map) {
    this.questionContent = map['Q'] ?? '';
    this.option1 = map['O'][0] ?? '';
    this.option2 = map['O'][1] ?? '';
    this.option3 = map['O'][2] ?? '';
    this.option4 = map['O'][3] ?? '';
    this.correctAnswer = map['A'];
  }
}
