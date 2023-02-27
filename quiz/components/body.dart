import 'package:bewithua/constants.dart';
import 'package:bewithua/controllers/add_controller.dart';
import 'package:bewithua/controllers/question_controller.dart';
import 'package:bewithua/core/styles/text_styles.dart';
import 'package:bewithua/models/question_type.dart';
import 'package:bewithua/utils/translation_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
    required this.questionType,
  }) : super(key: key);

  final QuestionType questionType;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late AddController _addController;
  late QuestionController _questionController;

  @override
  void initState() {
    _questionController = Get.put(QuestionController());
    _addController = Get.put(AddController());
    _questionController.sendContext(context);
    _questionController.setQuestionType(widget.questionType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ProgressBar(),
        ),
        const Spacer(flex: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          alignment: Alignment.center,
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  TrKey.question.tr.toUpperCase(),
                  style: text22W600,
                ),
                Text(
                  '${_questionController.questionNumber.value}/${_questionController.questions.length}',
                  style: text34W600Blue2,
                ),
              ],
            );
          }),
        ),
        const Spacer(flex: 20),
        Expanded(
          flex: 450,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _questionController.pageController,
              onPageChanged: _questionController.updateTheQnNum,
              itemCount: _questionController.questions.length,
              itemBuilder: (context, index) => QuestionCard(question: _questionController.questions[index]),
            ),
          ),
        ),
        InkWell(
          onTap: _questionController.nextQuestion,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            width: double.infinity,
            alignment: Alignment.center,
            child: Obx(() => Text(_questionController.isAnswered ? TrKey.forward.tr : TrKey.next.tr, style: text17W600Style)),
          ),
        ),
        if (_addController.bannerAd != null)
          SizedBox(
            width: Get.width,
            height: 60,
            child: AdWidget(ad: _addController.bannerAd!),
          )
      ],
    );
  }
}
