import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:quiz_app/models/questions.dart';
import 'package:quiz_app/screens/scrore/scrore_screen.dart';

// I use get package for our state management
class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Let's animated our progress bar

  late AnimationController _animationController;
  late Animation _animation;
  // So that I can access our animation outside
  Animation get animation => _animation;

  late PageController _pageController;
  PageController get pageController => _pageController;

  final List<Question> _questions = sampleData
      .map(
        (question) => Question(
          id: question['id'],
          question: question['question'],
          options: question['options'],
          answer: question['answer_index'],
        ),
      )
      .toList();

  List<Question> get questions => _questions;

  bool _isAnswerd = false;
  bool get isAnswerd => _isAnswerd;

  late int _correctAns;
  int get correctAns => _correctAns;

  late int _selectedAns;
  int get selectedAns => _selectedAns;

  // For more about obs please check documentation
  final RxInt _questionNumber = 1.obs;
  RxInt get questionNumber => _questionNumber;

  int _numOfCorrectAns = 0;
  int get numOfCorrectAns => _numOfCorrectAns;

  // Called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60s
    // So out plan is to fill the progress bar within 60s
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        update();
      });

    // Start our animation
    _animationController.forward().whenComplete(nextQuestion);
    _pageController = PageController();
    super.onInit();
  }

  // Called just befor the Controller is seleted from memory
  void onClose() {
    super.onClose();
    _animationController.dispose();
    _pageController.dispose();
  }

  void checkAns(Question question, int selectedIndex) {
    // Because once user press any option then it will run
    _isAnswerd = true;
    _correctAns = question.answer;
    _selectedAns = selectedIndex;

    if (_correctAns == _selectedAns) _numOfCorrectAns++;

    // It will stop the counter
    _animationController.stop();
    update();

    // Once user select an ans after 3s will go to the next qn
    Future.delayed(const Duration(seconds: 3), () {
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _isAnswerd = false;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease,
      );

      // Reset the counter
      _animationController.reset();

      // Then start it again
      // One timer is finish go to the next qn
      _animationController.forward().whenComplete(nextQuestion);
    } else {
      // Get a package to provide us simple way to navigate another page
      Get.to(const ScoreScreen());
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index + 1;
  }
}
