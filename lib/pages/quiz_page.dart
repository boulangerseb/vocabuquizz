import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/words_bloc.dart';
import '../blocs/words_event.dart';
import '../blocs/words_state.dart';
import '../widgets/question_widget.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz de vocabulaire'),
      ),
      body: BlocBuilder<WordsBloc, WordsState>(
        builder: (context, state) {
          if (state is QuestionChanged) {
            return QuestionWidget(word: state.word);
          } else if (state is QuizFinished) {
            return Text('Quiz terminé, votre score est : ${state.score}');
          } else {
            return const Text('Cliquez sur le bouton pour commencer le quiz');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          context.read<WordsBloc>().add(StartQuiz());
        },
      ),
    );
  }
}