import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbarController extends GetxController {
  PageController? pageController;
  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  int currentPageIndex = 0;
  void changePageIndex(int index) {
    currentPageIndex = index;
    update(["navbar"]);

    pageController?.animateToPage(currentPageIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }
}
