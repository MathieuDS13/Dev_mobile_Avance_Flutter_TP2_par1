import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1_part1_dev_mob/part1/models/questionary.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP1 ex1',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const _MyQuizPage(title: 'My Quiz'),
    );
  }
}

class _MyQuizPage extends StatelessWidget {
  final String title;

  const _MyQuizPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuizPage(title: title);
  }
}

class QuizPage extends StatelessWidget {
  final String title;

  const QuizPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title), centerTitle: true),
        body: Container(
            color: Colors.grey,
            child: Column(
              children: <Widget>[
                _getPicture(),
                _getQuestion(context),
                _getButtonRow(context)
              ],
            )));
  }

  void checkAnswer(bool userChoice, BuildContext context) {
    bool correctAnswer =
        Provider.of<Questionary>(context, listen: false).getCorrectAnswer();
    if (userChoice == correctAnswer) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Bonne réponse"),
      ));
      Provider.of<Questionary>(context, listen: false).getNextQuestion();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Mauvaise réponse"),
      ));
    }
  }

  _getPicture() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/200/200'),
          fit: BoxFit.fill,
        ),
        border: Border.all(
          color: Colors.white,
          width: 8,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  _getQuestion(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            Provider.of<Questionary>(context).getQuestionText(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }

  _getButtonRow(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            onPressed: () {
              checkAnswer(true, context);
            },
            child: const Text(
              'True',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
            onPressed: () {
              checkAnswer(false, context);
            },
            child: const Text(
              'False',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
          ),
        ]);
  }
}
