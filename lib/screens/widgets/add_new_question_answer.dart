import 'package:flutter/material.dart';

class AddNewQuestionAnswer extends StatelessWidget {
  final Color color;
  final String labelText;
  final String option;
  final TextEditingController controller;

  const AddNewQuestionAnswer({
    Key? key,
    required this.color,
    required this.labelText,
    required this.option,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
              child: Text(
            option,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: labelText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '*Required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
