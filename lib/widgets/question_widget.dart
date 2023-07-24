import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/words_bloc.dart';
import '../blocs/words_event.dart';
import '../blocs/words_state.dart';
import '../models/word.dart';

class QuestionWidget extends StatefulWidget {
  final Word? word;
  const QuestionWidget({this.word, super.key});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  final TextEditingController _controller = TextEditingController();
  String? message;
  Color? messageColor;
  late WordsBloc _wordsBloc;
  bool showMessage = false;


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WordsBloc, WordsState>(
      listener: (context, state) {
        if (state is QuestionCorrectChanged) {
          message = "Correct!";
          messageColor = Colors.green;
          showMessage = true;
        } else if (state is QuestionWrongChanged) {
          message = "Incorrect!";
          messageColor = Colors.red;
          showMessage = true;
        }

      },
      builder: (context, state) {
        if (state is QuestionChanged) {
          return Column(children: <Widget>[
            Text(state.word.translations[0]),
            showMessage ? Text(message ?? "", style: TextStyle(color: messageColor)) : Container(),
            Row(children: <Widget>[
              Expanded(child: TextField(controller: _controller,),),
              ElevatedButton(onPressed: () {
                context.read<WordsBloc>().add(SubmitAnswer(_controller.text));
                Future.delayed(const Duration(seconds: 1), () {
                  context.read<WordsBloc>().add(NextQuestion());
                  setState(() {
                    showMessage = false;
                  });
                });
              }, child: const Text('valider'),)
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _wordsBloc = context.read<WordsBloc>();
  }

  @override
  void dispose() {
    _wordsBloc.close();
    _controller.dispose();
    super.dispose();
  }

}