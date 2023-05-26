class QuizQuestion {
  final int? id;
  final String question;
  final String answer;
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  QuizQuestion({
    this.id,
    required this.question,
    required this.answer,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
    };
  }

  static QuizQuestion fromMap(Map<String, dynamic> map) {
    return QuizQuestion(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
      option1: map['option1'],
      option2: map['option2'],
      option3: map['option3'],
      option4: map['option4'],
    );
  }
}
