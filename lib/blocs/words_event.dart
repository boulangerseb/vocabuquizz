abstract class WordsEvent {}

class StartQuiz extends WordsEvent {}

class NextQuestion extends WordsEvent {}

class SubmitAnswer extends WordsEvent {
  final String userAnswer;
  SubmitAnswer(this.userAnswer);
}