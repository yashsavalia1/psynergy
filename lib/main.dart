import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:psynergy/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Psynergy',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const HomePage(),
    );
  }
}
