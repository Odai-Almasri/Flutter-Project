import 'package:flutter/material.dart';
import 'package:project/screens/widgets/button.dart';
import 'package:project/screens/widgets/create_quiz_question_answer.dart';

import '../sqlite/quiz_question.dart';
import '../sqlite/sqlite_handler.dart';
import 'add_new_question.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  SqliteHandler sqliteHandler = SqliteHandler();

  Future<List<QuizQuestion>> getQuestions() async {
    return await sqliteHandler.getStoredQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Button(
              text: 'Add new question',
              icon: Icons.add,
              width: double.infinity,
              onPressed: () async{
                final isRefrish = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddNewQuestion();
                }));

                if (isRefrish != null && isRefrish) {
                  setState(() {});
                }
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<QuizQuestion>>(
                future: getQuestions(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<QuizQuestion>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final question = snapshot.data![index];
                        return Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.grey[200],
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          question.question,
                                          style: const TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Delete Question'),
                                                content: const Text(
                                                    'Are you sure you want to delete this question?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      await sqliteHandler
                                                          .deleteQuestion(
                                                              question.id!);
                                                      setState(() {
                                                        Navigator.pop(context);
                                                      });
                                                    },
                                                    child: const Text('Delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CreateQuizQuestionAnswer(
                                        correctAnswer: question.answer,
                                        answer: question.option1,
                                        option: 'A',
                                      ),
                                      const SizedBox(height: 10),
                                      CreateQuizQuestionAnswer(
                                        correctAnswer: question.answer,
                                        answer: question.option2,
                                        option: 'B',
                                      ),
                                      const SizedBox(height: 10),
                                      CreateQuizQuestionAnswer(
                                        correctAnswer: question.answer,
                                        answer: question.option3,
                                        option: 'C',
                                      ),
                                      const SizedBox(height: 10),
                                      CreateQuizQuestionAnswer(
                                        correctAnswer: question.answer,
                                        answer: question.option4,
                                        option: 'D',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
