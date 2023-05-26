import 'package:flutter/material.dart';

class CreateQuizQuestionAnswer extends StatelessWidget {
  final String correctAnswer;
  final String answer;
  final String option;

  const CreateQuizQuestionAnswer({
    Key? key,
    required this.correctAnswer,
    required this.answer,
    required this.option,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
          color: correctAnswer == option ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Text(
        answer,
        style: TextStyle(
          fontSize: 18,
          color: correctAnswer == option ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
