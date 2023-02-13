import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
int corrects = 0, wrongs = 0;

void main() => runApp(const Quizz());

class Quizz extends StatelessWidget {
  const Quizz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.blueGrey,
            appBar: AppBar(
              title: Text('Quiz'),
              backgroundColor: Colors.teal,
            ),
            body: const SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: QuizApp(),
              ),
            )));
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> ticks = [];

  void getChoice(bool choice) {
    setState(() {
      bool correct = quizBrain.getAnswer();
      if ((ticks.length - 1) != quizBrain.lengthQns()) {
        if (correct == choice) {
          corrects++;
          ticks.add(const Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.green,
            size: 18.0,
          ));
        } else {
          wrongs++;
          ticks.add(const Icon(
            Icons.close_rounded,
            color: Colors.red,
            size: 18.0,
          ));
        }
        quizBrain.nextQuestion();
      } else {
        Alert(
          context: context,
          type: AlertType.warning,
          title: "QUIZ",
          desc:
              "You have reached the end of the quiz. Do you want to try again?",
          buttons: [
            DialogButton(
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                // ticks.clear();
                // quizBrain.myrange(0);
                corrects = 0;
                wrongs = 0;
                // quizBrain.reset();
                Navigator.pop(context);
                // main();
              },
              color: Color.fromRGBO(0, 179, 134, 1.0),
            ),
            DialogButton(
              child: Text(
                "No",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Alert(
                  context: context,
                  type: AlertType.info,
                  title: "Quiz",
                  desc: "You got $corrects Correct and $wrongs Wrong.",
                ).show();
              },
              gradient: LinearGradient(colors: [
                Color.fromRGBO(116, 116, 191, 1.0),
                Color.fromRGBO(52, 138, 199, 1.0)
              ]),
            )
          ],
        ).show();
        // ticks.removeRange(0, ticks.length);

        ticks.clear();
        quizBrain.myrange(0);
        quizBrain.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                  child: Text(
                quizBrain.getQuestion(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25.0, color: Colors.white),
              )),
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.green)),
              onPressed: () {
                getChoice(true);
              },
              child: const Text(
                'True',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.red)),
              onPressed: () {
                getChoice(false);
              },
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        )),
        Row(
          children: ticks,
        )
      ],
    );
  }
}
