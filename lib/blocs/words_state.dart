import '../models/word.dart';

abstract class WordsState {}


class WordsInitial extends WordsState {}

class QuestionChanged extends WordsState {
  final Word word;
  QuestionChanged(this.word);
}

class QuizInitial extends WordsState {}

class QuizFinished extends WordsState {
  final int score;
  QuizFinished(this.score);
}
