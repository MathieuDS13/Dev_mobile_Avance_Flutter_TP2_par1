import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp1_part1_dev_mob/part1/models/questionary.dart';
import 'quiz.dart';

void main() {
  runApp(ChangeNotifierProvider<Questionary>(
      create: (context) => Questionary(), child: const MyApp()));
}
