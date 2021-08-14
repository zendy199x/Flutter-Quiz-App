import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

// I use get package for our state management
class QuestionController extends GetxController
    with SingleGetTickerProviderMixin {
  // Let's animated our progress bar

  AnimationController? _animationController;
  Animation? _animation;
  // So that I can access our animation outside
  Animation get animation => _animation!;

  // Called immediately after the widget is allocated memory
  @override
  void onInit() {
    // Our animation duration is 60s
    // So out plan is to fill the progress bar within 60s
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        update();
      });

    // Start our animation
    _animationController!.forward();

    super.onInit();
  }
}
