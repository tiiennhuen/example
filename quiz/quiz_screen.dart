import 'package:bewithua/controllers/question_controller.dart';
import 'package:bewithua/core/widgets/background_wrapper.dart';
import 'package:bewithua/models/question_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  final QuestionType questionType;

  const QuizScreen({
    Key? key,
    required this.questionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());

    return BackgroundWrapper(
      hasBackButton: true,
      child: Body(questionType: questionType),
    );
  }
}
