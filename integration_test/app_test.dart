import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:psynergy/about_page.dart';
import 'package:psynergy/code_page.dart';
import 'package:psynergy/display_score_page.dart';
import 'package:psynergy/enter_code_page.dart';
import 'package:psynergy/home_page.dart';
import 'package:psynergy/main.dart' as app;
import 'package:psynergy/quiz_page.dart';
import 'package:psynergy/subject_page.dart';
import 'package:psynergy/subject_page_intro.dart';

void main() {
  group("App Test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("Full App Test", (tester) async {
      app.main();

      await tester.pumpAndSettle();

      //Tests about page routing
      final aboutButton = find.byKey(const Key("about"));

      await tester.tap(aboutButton);
      await tester.pumpAndSettle();

      expect(find.byType(AboutPage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);
      expect(find.byType(SubjectPageIntro), findsNothing);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(AboutPage), findsNothing);
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(SubjectPageIntro), findsNothing);

      //Tests subject page
      final subjectButton = find.byKey(const Key("subject_button"));

      await tester.tap(subjectButton);
      await tester.pumpAndSettle();

      expect(find.byType(SubjectPageIntro), findsOneWidget);
      expect(find.byType(AboutPage), findsNothing);
      expect(find.byType(HomePage), findsNothing);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(SubjectPage), findsOneWidget);
      expect(find.byType(SubjectPageIntro), findsNothing);

      final SubjectPageState subjectPageState =
          tester.state(find.byType(SubjectPage));

      for (int i = 0; i < 20; i++) {
        expect(subjectPageState.questionIndex, i);
        await tester.tap(find.byType(TextField));
        await tester.enterText(find.byType(TextField), "test");
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
      }

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(CodePage), findsOneWidget);
      expect(find.byType(SubjectPage), findsNothing);

      final codePage =
          find.byType(CodePage).evaluate().single.widget as CodePage;

      CollectionReference users =
          FirebaseFirestore.instance.collection('answers');
      final doc = await users.doc(codePage.id).get();

      expect(doc.exists, true);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(CodePage), findsNothing);

      await tester.tap(find.byKey(const Key("quiz_button")));
      await tester.pumpAndSettle();

      expect(find.byType(EnterCodePage), findsOneWidget);
      expect(find.byType(HomePage), findsNothing);

      //Enter code
      await tester.tap(find.byType(TextField));
      await tester.enterText(find.byType(TextField), "test");
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(QuizPage), findsOneWidget);
      expect(find.byType(EnterCodePage), findsNothing);

      final QuizPageState quizPageState = tester.state(find.byType(QuizPage));

      //Enter quiz answers
      for (int i = 0; i < 20; i++) {
        expect(quizPageState.questionIndex, i);
        await tester.tap(find.byType(TextField));
        await tester.enterText(find.byType(TextField), "test");
        await tester.testTextInput.receiveAction(TextInputAction.done);
        await tester.pump();
      }

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.byType(DisplayScorePage), findsOneWidget);
      expect(find.byType(QuizPage), findsNothing);

      final displayScorePage = find
          .byType(DisplayScorePage)
          .evaluate()
          .single
          .widget as DisplayScorePage;

      expect(displayScorePage.score, 20);
    });
  });
}
