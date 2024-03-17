import 'dart:convert';

import 'package:get/get.dart';
import 'package:wallet_app/services/storage_service.dart';
import 'package:wallet_app/services/wallet_provider.dart';
import 'package:wallet_app/services/web3services.dart';
import 'package:web3dart/web3dart.dart';

class HomeController extends GetxController {
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
    privateKey =
        await WalletService().createCredentials(StorageService().getMnemonic!);
    Map<String, String> jsonMap = {
      'privateKey': WalletService().privateKeyHex(privateKey!)
    };
    final aaa = json.encode(jsonMap);
    print(aaa);
  }

  Future<EtherAmount> accountBalance() async =>
      await web3service.getAccountBalance(EthereumAddress.fromHex(
          "0x599d394395b92b1037e7d8b655de0917c284cdf8"));
}
