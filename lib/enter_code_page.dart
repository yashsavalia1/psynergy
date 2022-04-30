import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:psynergy/quiz_helper.dart';
import 'package:psynergy/quiz_page.dart';

class EnterCodePage extends StatelessWidget {
  const EnterCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context),
      body: getBackground(
        Column(
          children: [
            getCard(
                "Enter the code that your friend gave you and see how well you know them!"),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: TextField(
                autocorrect: true,
                autofocus: true,
                style: const TextStyle(
                    fontFamily: "Ruda", fontSize: 20, color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Enter Code",
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                onSubmitted: (String val) {
                  if (val != "") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPage(
                          docId: val,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
