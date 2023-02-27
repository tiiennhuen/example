import 'dart:math';

import 'package:bewithua/constants.dart';
import 'package:bewithua/controllers/question_controller.dart';
import 'package:bewithua/core/styles/text_styles.dart';
import 'package:bewithua/models/question_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:styled_text/styled_text.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
    this.answerText,
  }) : super(key: key);

  final String text;
  final String? answerText;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          return InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: press,
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: getAnsweredColor(qnController, defaultColor: Colors.transparent),
                border: Border.all(
                  color: getTheRightColor(
                    qnController,
                    defaultColor: kGreyColor,
                  ),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: qnController.questionType != QuestionType.grammar
                        ? Text(
                            text,
                            style: text17W600Style.copyWith(
                              color: getTheRightColor(qnController),
                            ),
                          )
                        : StyledText(
                            text: _getGrammarText(qnController, text, answerText),
                            style: text17W600Style,
                            tags: {
                              'green': StyledTextTag(
                                style: text17W600Style.copyWith(
                                  color: kGreenColor,
                                ),
                              ),
                              'red': StyledTextTag(
                                style: text17W600Style.copyWith(
                                  color: kRedColor,
                                ),
                              ),
                            },
                          ),
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final size = min(constraints.maxWidth, constraints.maxHeight) / 2;
                      return Container(
                        height: size,
                        width: size,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: getTheRightColor(
                              qnController,
                              defaultColor: kGreyColor,
                            ),
                            width: 1.5,
                          ),
                        ),
                        child: getTheRightIcon(qnController),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool _isCorrectAns(QuestionController controller) => controller.isAnswered && index == controller.correctAns;

  bool _isIncorrectAns(QuestionController controller) =>
      controller.isAnswered && index == controller.selectedAns && controller.selectedAns != controller.correctAns;

  Color getAnsweredColor(QuestionController controller, {Color defaultColor = Colors.black}) =>
      (controller.isAnswered && (_isCorrectAns(controller) || _isIncorrectAns(controller))) ? Colors.white : defaultColor;

  Color getTheRightColor(QuestionController controller, {Color defaultColor = Colors.black}) {
    if (_isCorrectAns(controller)) {
      return kGreenColor;
    } else if (_isIncorrectAns(controller)) {
      return kRedColor;
    }
    return defaultColor;
  }

  Icon? getTheRightIcon(QuestionController controller) {
    if (_isCorrectAns(controller)) {
      return const Icon(Icons.done, size: 16, color: kGreenColor);
    } else if (_isIncorrectAns(controller)) {
      return const Icon(Icons.close, size: 16, color: kRedColor);
    }
    return null;
  }

  String _getGrammarText(
    QuestionController controller,
    String text,
    String? answerText,
  ) {
    if (controller.isAnswered) {
      return answerText ?? text;
    } else {
      return text;
    }
  }
}
