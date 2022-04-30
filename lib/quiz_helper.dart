import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  const Question(this.questionText, {Key? key}) : super(key: key);

  final String questionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Text(
        questionText,
        style: const TextStyle(
          fontFamily: 'Ruda',
          fontSize: 40,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class AnswerText extends StatelessWidget {
  const AnswerText(this.answerText, {Key? key}) : super(key: key);

  final String answerText;

  @override
  Widget build(BuildContext context) {
    return Text(
      answerText,
      style: const TextStyle(
        fontFamily: 'Ruda',
        fontSize: 40,
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    );
  }
}

AppBar mainAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: 30,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    centerTitle: true,
    title: const Text('PSYNERGY',
        style: TextStyle(
          fontFamily: 'Ruda',
          fontSize: 40,
        )),
    backgroundColor: Colors.red[200],
  );
}

Card getCard(String text) {
  return Card(
    margin: const EdgeInsets.all(10),
    color: Colors.white.withOpacity(0.7),
    child: Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Ruda',
          fontSize: 20,
          height: 1.25,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Container getBackground(Widget child) {
  return Container(
    constraints: const BoxConstraints.expand(),
    //background
    decoration: const BoxDecoration(
      image: DecorationImage(
        // uncommet one of the 3 images list below to try with different background image
        image: AssetImage('assets/images/PageImage.jpg'),
        //image: AssetImage('assets/images/IMG_0069.jpg'),
        //image: NetworkImage(urlImage),
        fit: BoxFit.cover,
      ),
    ),
    child: child,
  );
}
