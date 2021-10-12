import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tp1_part1_dev_mob/part2/models/questionary.dart';

part 'questionary_state.dart';

class QuestionaryCubit extends Cubit<QuestionaryState> {
  Questionary questionary;

  QuestionaryCubit(this.questionary) : super(QuestionaryInitial(questionary.getQuestionText()));

  void verifyQuestion(bool selectedAnswer) {
    bool goodAnswer = questionary.getCorrectAnswer();
    if (goodAnswer == selectedAnswer) {
      emit( const QuestionaryGoodAnswer());
      questionary.getNextQuestion();
      emit(QuestionaryChangeQuestion(questionary.getQuestionText()));
    } else {
      emit(QuestionaryBadAnswer(questionary.getQuestionText()));
    }
  }
}
