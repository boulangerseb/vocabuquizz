import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabuquizz2/blocs/words_event.dart';
import 'package:vocabuquizz2/blocs/words_state.dart';

import '../models/word.dart';
import '../repository/json_repository.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {
  final JsonRepository jsonRepository;
  List<Word> words;
  int currentQuestionIndex;

  WordsBloc({required this.jsonRepository})
      : words = List<Word>.empty(),
        currentQuestionIndex = 0,
        super(QuizInitial()) {

    on<StartQuiz>((event, emit) async {
      words = await jsonRepository.loadAndDecodeJson();
      if (words.isNotEmpty) {
        emit(QuestionChanged(words[currentQuestionIndex]));
      } else {
        // Gérer le cas où il n'y a pas de mots
      }
    });

    on<NextQuestion>((event, emit) async {
      print('next');
      if (currentQuestionIndex < words.length - 1) {
        currentQuestionIndex++;
        emit(QuestionChanged(words[currentQuestionIndex]));
      } else {
        emit(QuizFinished(1)); // Remplacer 1 par le bon score
      }
    });

    on<SubmitAnswer>((event, emit) async {
      if (event.userAnswer == words[currentQuestionIndex].translations[1]) {
        emit(QuestionCorrectChanged(words[currentQuestionIndex]));
      } else {
        emit(QuestionWrongChanged(words[currentQuestionIndex]));
      }
    });

  }

}