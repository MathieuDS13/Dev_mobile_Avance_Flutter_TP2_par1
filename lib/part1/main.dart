import 'package:flutter/material.dart';

import 'user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP1 ex1',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePageCardPage(title: 'Carte de visite'),
    );
  }
}

class MyHomePageCardPage extends StatefulWidget {
  const MyHomePageCardPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application.

  final String title;

  @override
  State<MyHomePageCardPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePageCardPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
          alignment: Alignment.center,
          child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          _getCard(
              User("Mathieu", "Da Silva", "xxxxxx@xxxxxx.xxxx", "xxxxxxxxxx")),
          _getAvatar()
        ],
      )),
    );
  }

  Container _getCard(User user) {
    return Container(
        width: 300,
        height: 300,
        color: Colors.lightBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "${user.firstname}  ${user.lastname}",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text("Mail : " + user.mail,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            Text("Twitter : " + user.twitter,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
          ],
        ));
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        image: const DecorationImage(
          image: NetworkImage('https://picsum.photos/100/100'),
          fit: BoxFit.none,
        ),
        border: Border.all(
          color: Colors.white,
          width: 8,
        ),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }
}
