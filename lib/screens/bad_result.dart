import 'package:flutter/material.dart';
import 'package:project/screens/widgets/button.dart';
import 'home.dart';

class BadResult extends StatelessWidget {
  final int score;
  final int total;

  const BadResult({Key? key, required this.score, required this.total})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz App'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Oops!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            const Image(
              image: AssetImage('assets/images/fail.png'),
              height: 200,
            ),
            const SizedBox(height: 20),
            Text('Your Score : $score / $total',
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.green)),
            const Text(
              'Sorry , Better luck next time!',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            Button(
                text: 'Back to Home',
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                })
          ],
        )));
  }
}
