import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psynergy/quiz_helper.dart';

class DisplayScorePage extends StatelessWidget {
  final int score;

  const DisplayScorePage({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: getBackground(
        Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: score / 20.0),
                duration: const Duration(milliseconds: 1000),
                builder: (context, value, _) =>
                    CircularProgressIndicator(value: value),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                "You got $score / 20 right!",
                style: const TextStyle(
                  fontFamily: 'Ruda',
                  fontSize: 40,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
