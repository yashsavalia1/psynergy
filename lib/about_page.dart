import 'package:flutter/material.dart';
import 'package:psynergy/quiz_helper.dart';

//ANCHOR Done

AppBar aboutAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      iconSize: 30,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    centerTitle: true,
    title: const Text('About',
        style: TextStyle(
          fontFamily: 'Ruda',
          fontSize: 40,
        )),
    backgroundColor: Colors.red[200],
  );
}

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: aboutAppBar(context),
      body: getBackground(
        getCard(
            "\nWelcome to Psynergy!\n\nThis app tests how close you are with your friend by having you answer 20 questions "
            "about yourself and then seeing how many your friend can guess right!\n\n"
            "Created by Yash Savalia, Winifred Nie, Yudi Chen, and Zhaoqi Xia"),
      ),
    );
  }
}
