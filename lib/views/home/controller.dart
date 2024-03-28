import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/services/storage_service.dart';
import 'package:wallet_app/services/wallet_provider.dart';
import 'package:wallet_app/services/web3services.dart';
import 'package:wallet_app/views/login/view.dart';
import 'package:web3dart/web3dart.dart';

class HomeController extends GetxController {
  RxBool isShow = false.obs;
  int currentPageIndex = 0;
  int accountIndex = 0;

  String? currentAccount;

  List<Widget> views = [MnomenicPhraseView(), const Text("sss")];

  void changePageIndex(int index) {
    currentPageIndex = index;

    update(["bottomNavbar"]);
  }

  final web3service = Get.put(Web3Services());
  @override
  void onInit() async {
    currentAccount = StorageService().addresses.first;
    // await initKey();
    super.onInit();
  }

  getBalance(String privateKey) {}
  Future<EtherAmount> accountBalance(EthereumAddress address) async =>
      await web3service.getAccountBalance(EthereumAddress.fromHex(address.hex));

  void addAccount() {
    Get.find<WalletService>()
        .createCredentials(StorageService().addresses.length);
  }
}
