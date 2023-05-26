import 'package:flutter/material.dart';
import 'package:project/screens/widgets/button.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sorry!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'You must add at least 5 questions to start.',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Image(image: AssetImage('assets/images/faq.png'), height: 250),
          const SizedBox(height: 10),
          Button(
            text: 'Back to Home',
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      )),
    );
  }
}
