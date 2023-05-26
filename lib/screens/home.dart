import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/faq.dart';
import 'package:project/screens/quiz.dart';
import 'package:project/screens/widgets/button.dart';
import 'package:project/sqlite/quiz_question.dart';
import 'package:project/sqlite/sqlite_handler.dart';

import 'create_quiz.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    SqliteHandler sqliteHandler = SqliteHandler();

    Future<List<QuizQuestion>> getQuestions() async {
      return await sqliteHandler.getStoredQuestions();
    }

    return FutureBuilder(
      future: getQuestions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Quiz App'),
                centerTitle: true,
              ),
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const UserAccountsDrawerHeader(
                      accountName: Text('Khaled Alhendawi'),
                      accountEmail: Text('khaled.alhendawi@gmail.com'),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.pink,
                        child: Text(
                          'K',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text("Create quiz"),
                        onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const CreateQuiz();
                            },
                          ));

                          setState(() {});
                        }),
                    ListTile(
                        leading: const Icon(Icons.quiz),
                        title: const Text("Start quiz"),
                        onTap: () => {
                              Navigator.pop(context),
                              if (snapshot.data.length < 5)
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Faq()),
                                  )
                                }
                              else
                                {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Quiz()),
                                  )
                                }
                            }),
                    const Divider(),
                    ListTile(
                        leading: const Icon(Icons.exit_to_app),
                        title: const Text("Exit"),
                        onTap: () => {
                              SystemNavigator.pop(),
                            }),
                  ],
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('assets/images/quiz.png'),
                      height: 300,
                    ),
                    Button(
                      text: 'Let\'s Start!',
                      onPressed: () {
                        if (snapshot.data.length < 5) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Faq()),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Quiz()),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }
}
