import 'package:flutter/material.dart';
import 'package:psynergy/enter_code_page.dart';
import 'package:psynergy/quiz_helper.dart';
import 'package:psynergy/subject_page_intro.dart';
import 'package:psynergy/about_page.dart';

final TextStyle titleStyle = TextStyle(
    color: Colors.red[200],
    fontSize: 50,
    fontFamily: 'Ruda',
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w900);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.pink[50],
        body: getBackground(
          Center(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'PSYNERGY',
                  style: titleStyle,
                ),
                const SizedBox(height: 150),
                ElevatedButton(
                  key: const Key("subject_button"),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 3)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[200]),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 20, fontFamily: "Ruda"))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SubjectPageIntro()));
                  },
                  child: const Text('How well do they know you?'),
                ),
                ElevatedButton(
                  key: const Key("quiz_button"),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 3)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[200]),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 20, fontFamily: "Ruda"))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EnterCodePage()));
                  },
                  child: const Text('How well do you know them?'),
                ),
                ElevatedButton(
                  key: const Key("about"),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 3)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[200]),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 20, fontFamily: "Ruda"))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutPage()));
                  },
                  child: const Text('About'),
                ),
              ],
            ),
          ),
        ));
  }
}
