import '../models/word.dart';

abstract class WordsState {}


class WordsInitial extends WordsState {}

class QuestionChanged extends WordsState {
  final Word word;
  QuestionChanged(this.word);
}

class AnswerIsCorrect extends WordsState {}

class AnswerIsWrong extends WordsState {}

class QuestionCorrectChanged extends QuestionChanged {
  QuestionCorrectChanged(super.word);
}

class QuestionWrongChanged extends QuestionChanged {
  QuestionWrongChanged(super.word);
}

class QuizInitial extends WordsState {}

class QuizFinished extends WordsState {
  final int score;
  QuizFinished(this.score);
}
