import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/services/storage_service.dart';
import 'package:wallet_app/services/wallet_provider.dart';
import 'package:wallet_app/views/confirm_seed/controller.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxInt currentIndex = 0.obs;

  RxList<String>? phrase = RxList();

  RxBool isVisible = false.obs;
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

    if (Get.find<StorageService>().getMnemonic == null) {
      _createNewWallet();
    } else {
      // 0x599d394395b92b1037e7d8b655de0917c284cdf8
      phrase?.clear();

      phrase?.value = Get.find<StorageService>().getMnemonic!.split(" ");
    }
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

  void toNextStep(int index) async {
    currentIndex.value = index;
    steps[index - 1]["isDone"] = true;

    if (index == 2) {
      final confirmCont = Get.put(ConfirmSeedController());

      confirmCont.initLists(phrase!.toList());
    }

    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _createNewWallet() async {
    await WalletService().createCredentials(0);
    phrase?.value = StorageService().getMnemonic!.split(" ");

    // await creamultiple(nomanic);
  }
}
