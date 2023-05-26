import 'package:flutter/material.dart';
import 'package:project/screens/widgets/add_new_question_answer.dart';
import 'package:project/screens/widgets/button.dart';
import 'package:project/sqlite/quiz_question.dart';
import 'package:project/sqlite/sqlite_handler.dart';

class AddNewQuestion extends StatefulWidget {
  const AddNewQuestion({super.key});

  @override
  State<AddNewQuestion> createState() => _AddNewQuestionState();
}

class _AddNewQuestionState extends State<AddNewQuestion> {
  final formKey = GlobalKey<FormState>();
  final controllerQuestion = TextEditingController();
  final controllerA = TextEditingController();
  final controllerB = TextEditingController();
  final controllerC = TextEditingController();
  final controllerD = TextEditingController();
  String correctAnswer = 'A';

  SqliteHandler sqliteHandler = SqliteHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add New Question'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controllerQuestion,
                decoration: const InputDecoration(
                  labelText: 'Question',
                  prefixIcon: Icon(Icons.question_mark),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a question';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AddNewQuestionAnswer(
                color: Colors.yellow,
                labelText: 'First Answer',
                option: 'A',
                controller: controllerA,
              ),
              const SizedBox(height: 10),
              AddNewQuestionAnswer(
                color: Colors.green,
                labelText: 'Second Answer',
                option: 'B',
                controller: controllerB,
              ),
              const SizedBox(height: 10),
              AddNewQuestionAnswer(
                color: Colors.blueGrey,
                labelText: 'Third Answer',
                option: 'C',
                controller: controllerC,
              ),
              const SizedBox(height: 10),
              AddNewQuestionAnswer(
                color: Colors.pink,
                labelText: 'Fourth Answer',
                option: 'D',
                controller: controllerD,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select the correct Answer : ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: correctAnswer,
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.teal,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        correctAnswer = newValue!;
                      });
                    },
                    items: <String>['A', 'B', 'C', 'D']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Button(
                text: 'Add question',
                width: double.infinity,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    sqliteHandler.addQuestion(QuizQuestion(
                      question: controllerQuestion.text,
                      answer: correctAnswer,
                      option1: controllerA.text,
                      option2: controllerB.text,
                      option3: controllerC.text,
                      option4: controllerD.text,
                    ));
                    Navigator.pop(context, true);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
