import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/main.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt currentIndex = 0.obs;
  RxList<Map<String, dynamic>> steps = [
    {
      "index": 0,
      "title": "Create password",
      "isDone": false,
    },
    {
      "index": 1,
      "title": "Secure wallet",
      "isDone": false,
    },
    {
      "index": 2,
      "title": "Confirm Secret Recovery Phrase",
      "isDone": false,
    }
  ].obs;

  RxBool isLoading = false.obs;

  final RxString errorText = ''.obs;

  void login() async {
    final String username = usernameController.text.trim();
    final String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      errorText.value = 'Please enter username and password.';
      return;
    }

    isLoading.value = true;

    // Simulating login process for demonstration
    await Future.delayed(const Duration(seconds: 2));

    // After successful login, navigate to HomeScreen
    Get.off(const HomeScreen());
  }

  void toNextStep(int index) {
    currentIndex.value = index;
    steps[index - 1]["isDone"] = true;
  }
}
