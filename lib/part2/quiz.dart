import 'package:flutter/material.dart';
import 'package:tp1_part1_dev_mob/part2/questionary.dart';


Questionary questionary = Questionary();

void main() {
  runApp(const MyApp());
}

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

class _MyQuizPage extends StatefulWidget {
  final String title;

  const _MyQuizPage({Key? key, required this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() => QuizPageState();
}

class QuizPageState extends State<_MyQuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), centerTitle: true),
        body: Container(
          color: Colors.grey,
            child: Column(
          children: <Widget>[_getPicture(), _getQuestion(), _getButtonRow()],
        )));
  }

  void checkAnswer(bool userChoice) {
    bool correctAnswer = questionary.getCorrectAnswer();
    setState(() {
      if (userChoice == correctAnswer) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Bonne réponse"),
        ));
        questionary.getNextQuestion();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Mauvaise réponse"),
        ));
      }
    });
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

  _getQuestion() {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text(
            questionary.getQuestionText(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );
  }

  _getButtonRow() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
      TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green)),
        onPressed: () {
          checkAnswer(true);
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
          checkAnswer(false);
        },
        child: Text(
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
