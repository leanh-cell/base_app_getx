class Question {
  Question({
    this.id,
    this.storeId,
    this.quizId,
    this.question,
    this.questionImage,
    this.answerA,
    this.answerB,
    this.answerC,
    this.answerD,
    this.rightAnswer,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? storeId;
  int? quizId;
  String? question;
  String? questionImage;
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;
  String? rightAnswer;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"] == null ? null : json["id"],
        storeId: json["store_id"] == null ? null : json["store_id"],
        quizId: json["quiz_id"] == null ? null : json["quiz_id"],
        question: json["question"] == null ? null : json["question"],
        questionImage:
            json["question_image"] == null ? null : json["question_image"],
        answerA: json["answer_a"] == null ? null : json["answer_a"],
        answerB: json["answer_b"] == null ? null : json["answer_b"],
        answerC: json["answer_c"] == null ? null : json["answer_c"],
        answerD: json["answer_d"] == null ? null : json["answer_d"],
        rightAnswer: json["right_answer"] == null ? null : json["right_answer"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "store_id": storeId == null ? null : storeId,
        "quiz_id": quizId == null ? null : quizId,
        "question": question == null ? null : question,
        "question_image": questionImage == null ? null : questionImage,
        "answer_a": answerA == null ? null : answerA,
        "answer_b": answerB == null ? null : answerB,
        "answer_c": answerC == null ? null : answerC,
        "answer_d": answerD == null ? null : answerD,
        "right_answer": rightAnswer == null ? null : rightAnswer,
      };
}
