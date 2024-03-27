import 'dart:math';

import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  Future<String> generateMnemonic() async {
    return bip39.generateMnemonic();
  }

  Future<String> createCredentials(String mnemonic, int index) async {
    final privateKey = await _createMultipleCredentials(mnemonic, index);
    return privateKey;
  }

  Future<String> _createMultipleCredentials(String mnemonic, int index) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final hdWallet = bip32.BIP32.fromSeed(seed);
    print(mnemonic);

    final childKey = hdWallet.derivePath("m/44'/60'/$index'/0/0");
    final privateKeyHex = childKey.privateKey;
    final accountkey = bytesToHex(privateKeyHex!);

    return accountkey;
  }

  // String bytesToHex(Uint8List bytes) {
  //   final hexChars = List<String>.from(
  //     bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')),
  //   );
  //   return hexChars.join();
  // }

  String privateKeyHex(EthPrivateKey key) {
    return bytesToHex(key.privateKey);
  }

  String revealPrivateKey() {
    var rng = Random.secure();
    EthPrivateKey priKey = EthPrivateKey.createRandom(rng);
    String s = bytesToHex(priKey.privateKey);
    return s;
  }
}
