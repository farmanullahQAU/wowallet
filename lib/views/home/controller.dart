import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/services/wallet_provider.dart';
import 'package:wallet_app/services/web3services.dart';
import 'package:wallet_app/views/login/view.dart';
import 'package:web3dart/web3dart.dart';

class HomeController extends GetxController {
  int currentPageIndex = 0;
  List<Widget> views = [MnomenicPhraseView(), const Text("sss")];

  void changePageIndex(int index) {
    currentPageIndex = index;

    update(["bottomNavbar"]);
  }

  final web3service = Get.put(Web3Services());
  EthPrivateKey? privateKey;
  EtherAmount? balance;
  @override
  void onInit() async {
    await initKey();
    balance = await accountBalance();
    super.onInit();
  }

  initKey() async {
    // print(StorageService().getMnemonic!);
    final aa = await WalletService().createCredentials(
        "across boil reveal wild know sword pigeon express nerve wink smoke stem",
        0);
    // Map<String, String> jsonMap = {
    //   'privateKey': WalletService().privateKeyHex(privateKey!)
    // };
    // final aaa = json.encode(jsonMap);
    // final aa = WalletService().revealPrivateKey();

    // final key = WalletService().privateKeyHex(aa);
  }

  Future<EtherAmount> accountBalance() async =>
      await web3service.getAccountBalance(EthereumAddress.fromHex(
          "0x599d394395b92b1037e7d8b655de0917c284cdf8"));
}
