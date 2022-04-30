import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:psynergy/display_score_page.dart';
import './quiz_helper.dart';

const questions = [
  "What's their favorite color?",
  "What's their biggest pet peeve?",
  "What's their favorite ice cream flavor?",
  "What's their favorite song?",
  "If you could have a superpower, what would it be?",
  "What's their hometown?",
  "What's their favorite author?",
  "What major are they or do they want to be?",
  "What was their favorite subject in school?",
  "What are they scared of most?",
  "What's their favorite movie?",
  "What's their favorite restaurant?",
  "If they had to describe themself as an animal, what would it be?",
  "What would be their dream job?",
  "What's their greatest strength?",
  "What's their star sign?",
  "What's one thing they can't live without?",
  "If they could move to any other country, which will it be?",
  "What's their comfort food?",
  "What's their favorite hobby?",
];

class QuizPage extends StatefulWidget {
  final String docId;

  const QuizPage({Key? key, required this.docId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return QuizPageState();
  }
}

class QuizPageState extends State<QuizPage> {
  final controller = TextEditingController();
  int questionIndex = 0;
  int totScore = 0;
  var rightAnswers = List<String>.filled(20, "");
  var givenAnswers = List<String>.filled(20, "");
  bool showSubmit = false;
  Future<DocumentSnapshot<Object?>>? future;

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

  void showTotal() {
    answerQuestion(controller.text);
    for (int i = 0; i < 20; i++) {
      if (givenAnswers[i].trim().toLowerCase() ==
          rightAnswers[i].trim().toLowerCase()) {
        totScore++;
      }
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayScorePage(score: totScore),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    CollectionReference users =
        FirebaseFirestore.instance.collection('answers');
    future = users.doc(widget.docId).get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: future,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: mainAppBar(context),
            body: getBackground(Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: const Text("Something went wrong!"),
            )),
          );
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Scaffold(
            appBar: mainAppBar(context),
            body: getBackground(Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: const Text("Invalid Code!"),
            )),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          data.forEach((String key, dynamic value) {
            String val = value.toString();
            rightAnswers[int.parse(key)] = val;
          });

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
                          fontFamily: "Ruda",
                          fontSize: 20,
                          color: Colors.white),
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
                        onPressed: showTotal,
                        child: const Text(
                          "Submit",
                        ),
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 3)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red[200]),
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                    fontSize: 40, fontFamily: "Ruda"))),
                      ),
                    ),
                ],
              ),
            ),
          );
        }

        //Loading
        return Scaffold(
          appBar: mainAppBar(context),
          body: getBackground(
            Column(
              children: const [CircularProgressIndicator()],
            ),
          ),
        );
      },
    );
  }
}
