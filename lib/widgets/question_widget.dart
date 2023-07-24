import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/words_bloc.dart';
import '../blocs/words_state.dart';
import '../models/word.dart';

class QuestionWidget extends StatelessWidget {
  final Word? word;
  const QuestionWidget({this.word, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordsBloc, WordsState>(
      builder: (context, state) {
        if (state is QuestionChanged) {
          return Column(children: <Widget>[
            Text(state.word.translations[0]),
            Row(children: <Widget>[
              const Expanded(child: TextField(),),
              ElevatedButton(onPressed: () {}, child: const Text('valider'),)
            ],)
          ]);
          //return Text(state.word.translations[0]);
        } else if (state is QuizFinished) {
          return const Text('Quiz finished!');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}