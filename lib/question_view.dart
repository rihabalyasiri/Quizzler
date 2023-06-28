import 'package:flutter/material.dart';
import 'package:quizzler/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key});

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  QuestionBrain questionBrain = QuestionBrain();
  List<Icon> scoreKeeper = [];

  void restartQuizzler() {
    setState(() {
      questionBrain.restart();
      scoreKeeper = [];
      Navigator.pop(context);
    });
  }

  void checkAnswer({required bool userAnswer, required bool questionAnswer}) {
    setState(() {
      if (userAnswer == questionAnswer) {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Text(
                questionBrain.getQuestionText(),
                style: const TextStyle(fontSize: 20, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    bool questionAnswer = questionBrain.getQuestionAnswer();
                    checkAnswer(
                        userAnswer: true, questionAnswer: questionAnswer);
                    bool isNextQuestion = questionBrain.nextQuestion();
                    if (!isNextQuestion) {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Questions are finished",
                        desc: "Try Again!",
                        buttons: [
                          DialogButton(
                            onPressed: () {
                              restartQuizzler();
                            },
                            width: 120,
                            child: const Text(
                              "Start",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ).show();
                    }
                  },
                  child: const Text(
                    "True",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    bool questionAnswer = questionBrain.getQuestionAnswer();
                    checkAnswer(
                        userAnswer: false, questionAnswer: questionAnswer);
                    bool isNextQuestion = questionBrain.nextQuestion();
                    if (!isNextQuestion) {
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Questions are finished",
                        desc: "Try Again!",
                        buttons: [
                          DialogButton(
                            onPressed: () {
                              restartQuizzler();
                            },
                            width: 120,
                            child: const Text(
                              "Start",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ],
                      ).show();
                    }
                  },
                  child: const Text("False",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Row(children: scoreKeeper)
        ],
      ),
    );
  }
}
