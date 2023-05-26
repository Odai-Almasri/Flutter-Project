import 'package:flutter/material.dart';
import 'package:project/screens/bad_result.dart';
import 'package:project/screens/excellent_result.dart';
import 'package:project/screens/good_result.dart';
import 'package:project/screens/widgets/start_quiz_question_answer.dart';

import '../sqlite/quiz_question.dart';
import '../sqlite/sqlite_handler.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  SqliteHandler sqliteHandler = SqliteHandler();
  int currentQuestion = 1;
  int score = 0;

  Future<List<QuizQuestion>> getQuestions() async {
    return await sqliteHandler.getStoredQuestions();
  }

  void selectAnswer(QuizQuestion question, String answer, int total) {
    if (currentQuestion < total) {
      setState(() {
        currentQuestion++;
      });
    } else {
      if (score / total >= 0.5) {
        if (score / total >= 0.75) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return ExcellentResult(
              score: score,
              total: total,
            );
          }));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return GoodResult(
              score: score,
              total: total,
            );
          }));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return BadResult(score: score, total: total);
        }));
      }
    }

    if (question.answer == answer) score++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<QuizQuestion>>(
        future: getQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<QuizQuestion> questions = snapshot.data!;
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Question $currentQuestion /',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${questions.length}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        questions[currentQuestion - 1].question,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StartQuizQuestionAnswer(
                      answer: questions[currentQuestion - 1].option1,
                      onTap: () {
                        selectAnswer(questions[currentQuestion - 1], 'A',
                            questions.length);
                        print(score);
                      },
                    ),
                    const SizedBox(height: 10),
                    StartQuizQuestionAnswer(
                      answer: questions[currentQuestion - 1].option2,
                      onTap: () {
                        selectAnswer(questions[currentQuestion - 1], 'B',
                            questions.length);
                      },
                    ),
                    const SizedBox(height: 10),
                    StartQuizQuestionAnswer(
                      answer: questions[currentQuestion - 1].option3,
                      onTap: () {
                        selectAnswer(questions[currentQuestion - 1], 'C',
                            questions.length);
                      },
                    ),
                    const SizedBox(height: 10),
                    StartQuizQuestionAnswer(
                      answer: questions[currentQuestion - 1].option4,
                      onTap: () {
                        selectAnswer(questions[currentQuestion - 1], 'D',
                            questions.length);
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
