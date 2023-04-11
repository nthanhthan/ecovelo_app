import 'dart:async';

import 'package:ecoveloapp/app/core.dart';
import 'package:flutter/material.dart';

class OnBoardingController extends GetxController {
  late PageController pageController;
  RxInt currentPage = 0.obs;
  int endPage = 2;
  Timer? autoNextTabSchedule;
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentPage.value);
  }

  @override
  void onReady() {
    super.onReady();
    _autoNextTabScheule();
  }

  @override
  void onClose() {
    cancelNextTabScheule();
    super.onClose();
  }

  void onPageChange(int index) {
    if (currentPage.value != index) {
      currentPage.value = index;
      _autoNextTabScheule();
    }
  }

  void onNextPage() {
    cancelNextTabScheule();
    if (currentPage.value < endPage) {
      _forceNextPage();
      _autoNextTabScheule();
    } else {
      Get.offNamed<void>(Routes.signin);
    }
  }

  void _forceNextPage() {
    if (currentPage < endPage) {
      currentPage++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(
            milliseconds: AppProperties.defaultTransitionDuration),
        curve: Curves.ease,
      );
    }
  }

  void cancelNextTabScheule() {
    autoNextTabSchedule?.cancel();
  }

  void _autoNextTabScheule() async {
    cancelNextTabScheule();
    autoNextTabSchedule = Timer(const Duration(seconds: 2), () {
      if (currentPage < endPage) {
        _forceNextPage();
        _autoNextTabScheule();
      }
    });
  }
}
