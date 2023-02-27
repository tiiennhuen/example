import 'package:bewithua/constants.dart';
import 'package:bewithua/controllers/question_controller.dart';
import 'package:bewithua/core/styles/text_styles.dart';
import 'package:bewithua/models/questions.dart';
import 'package:bewithua/screens/quiz/components/option.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_text/styled_text.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final _controller = Get.put(QuestionController());
    return Column(
      children: <Widget>[
        Expanded(
          flex: 12,
          child: _buildTitle(mq),
        ),
        ...question.options.mapIndexed((index, e) {
          return Expanded(
            flex: 7,
            child: Column(
              children: <Widget>[
                const Spacer(),
                Expanded(
                  flex: 6,
                  child: Option(
                    index: index,
                    text: e,
                    answerText: question.answers?[index],
                    press: () {
                      if (_controller.animationController != null && _controller.animationController!.isAnimating) {
                        _controller.checkAns(question, index);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildTitle(Size mq) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (question.image != null)
            Image.asset(
              question.image!,
              height: mq.height / 10,
            ),
          StyledText(
            textAlign: TextAlign.center,
            text: question.question,
            style: text22W600,
            tags: {
              'blue': StyledTextTag(style: text22W600.copyWith(color: kBlue2)),
            },
          ),
        ],
      ),
    );
  }
}
