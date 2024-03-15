import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/services/wallet_provider.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt currentIndex = 0.obs;

  RxList<String>? phrase;
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

  late PageController pageViewController;

  @override
  void onInit() {
    pageViewController = PageController();
    createNewWallet();
    super.onInit();
  }

  @override
  void onClose() {
    pageViewController.dispose();
    super.onClose();
  }

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

    toNextStep(1);
  }

  void toNextStep(int index) {
    currentIndex.value = index;
    steps[index - 1]["isDone"] = true;

    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future<void> createNewWallet() async {
    final nomanic = await WalletService().generateMnemonic();

    final key = await WalletService().createCredentials(nomanic);

    phrase?.value = nomanic.split(" ");
  }
}
