import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp1_part1_dev_mob/part2/models/questionary.dart';
import 'package:tp1_part1_dev_mob/part2/business_logic/cubits/questionary_cubit.dart';

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
      home: BlocProvider(
          create: (context) => QuestionaryCubit(Questionary()),
          child: const _MyQuizPage(title: 'My Quiz')),
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
            child: BlocListener<QuestionaryCubit, QuestionaryState>(
              listener: (context, state) {
                if (state is QuestionaryBadAnswer) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Mauvaise réponse !"),
                    duration: Duration(milliseconds: 300),
                  ));
                  if (state is QuestionaryGoodAnswer) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Bonne réponse !"),
                      duration: Duration(milliseconds: 300),
                    ));
                  }
                }
              },
              child: Column(
                children: <Widget>[
                  _getPicture(),
                  _getQuestion(context),
                  _getButtonRow(context)
                ],
              ),
            )));
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
          child: BlocBuilder<QuestionaryCubit, QuestionaryState>(
            builder: (context, state) {
              if (state is QuestionaryChangeQuestion) {
                return Text(
                  state.newQuestionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                );
              }
              if (state is QuestionaryInitial) {
                return Text(
                  state.questionText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                );
              }
              if (state is QuestionaryBadAnswer) {
                return Text(
                  state.questionShow,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                );
              }
              throw Exception("Problème dans les states");
            },
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
              BlocProvider.of<QuestionaryCubit>(context).verifyQuestion(true);
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
              BlocProvider.of<QuestionaryCubit>(context).verifyQuestion(false);
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
