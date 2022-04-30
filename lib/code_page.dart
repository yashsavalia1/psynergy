import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psynergy/quiz_helper.dart';

//ANCHOR Done
class CodePage extends StatelessWidget {
  final String id;

  const CodePage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: mainAppBar(context),
      body: getBackground(
        Column(
          children: [
            getCard(
                "Now copy the generated code below and send it to your friends!"),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: SelectableText(
                id,
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
