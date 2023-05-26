import 'package:flutter/material.dart';

class StartQuizQuestionAnswer extends StatelessWidget {
  final String answer;
  final VoidCallback onTap;

  const StartQuizQuestionAnswer({
    Key? key,
    required this.answer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          answer,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
