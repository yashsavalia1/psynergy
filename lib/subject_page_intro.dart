import 'package:flutter/material.dart';
import 'quiz_helper.dart';
import 'subject_page.dart';

const String intro_2 =
    'Then send the generated code to your friends to test how well they know you 🥳';

class SubjectPageIntro extends StatelessWidget {
  const SubjectPageIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context),
      body: getBackground(
        Column(
          children: [
            Card(
              margin: const EdgeInsets.all(10),
              color: Colors.white.withOpacity(0.7),
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Text(
                  "Answer the following 20 questions about yourself."
                  '\n\nThen send the generated code to your friends to test them on how well they know you! 🥳',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: "Ruda",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 150),
            ElevatedButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 3)),
                  backgroundColor: MaterialStateProperty.all(Colors.red[200]),
                  textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 30, fontFamily: "Ruda"))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubjectPage()));
              },
              child: const Text('Start'),
            ),
          ],
        ),
      ),
    );
  }
}
