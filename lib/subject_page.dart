import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psynergy/code_page.dart';
import 'package:psynergy/quiz_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const questions = [
  "What's your favorite color?",
  "What's your biggest pet peeve?",
  "What's your favorite ice cream flavor?",
  "What's your favorite song?",
  "If you could have a superpower, what would it be?",
  "What's your hometown?",
  "What's your favorite author?",
  "What major are you or what major do you want to be?",
  "What was your favorite subject in school?",
  "What are you scared of most?",
  "What's your favorite movie?",
  "What's your favorite restaurant?",
  "If you had to describe yourself as an animal, what would it be?",
  "What would be your dream job?",
  "What's your greatest strength?",
  "What's your star sign?",
  "What's one thing you can't live without?",
  "If you could move to any other country, which would it be?",
  "What's your comfort food?",
  "What's your favorite hobby?",
];

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SubjectPageState();
  }
}

class SubjectPageState extends State<SubjectPage> {
  final controller = TextEditingController();
  var givenAnswers = List<String>.filled(20, "");
  int questionIndex = 0;
  bool showSubmit = false;

  void answerQuestion(String answer) {
    setState(() {
      givenAnswers[questionIndex] = answer;

      if (questionIndex < 19) {
        questionIndex++;
        controller.clear();
      }

      if (questionIndex == 19) showSubmit = true;
    });
  }

  Future<void> addAnswers() {
    //Firestore future
    var answersCollection = FirebaseFirestore.instance.collection('answers');
    answerQuestion(controller.text);
    return answersCollection.add({
      for (var answer in givenAnswers)
        givenAnswers.indexOf(answer).toString(): answer
    }).then((docRef) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CodePage(id: docRef.id)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context),
      body: getBackground(
        Column(
          children: [
            LinearProgressIndicator(
              value: questionIndex / 20,
            ),
            Question(
              questions[questionIndex],
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TextField(
                controller: controller,
                autocorrect: true,
                autofocus: true,
                style: const TextStyle(
                    fontFamily: "Ruda", fontSize: 20, color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Answer",
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                onSubmitted: (String val) {
                  if (val != "") {
                    answerQuestion(val);
                  }
                },
              ),
            ),
            if (showSubmit)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  onPressed: addAnswers,
                  child: const Text("Submit"),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 3)),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.red[200]),
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(fontSize: 30, fontFamily: "Ruda"))),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
