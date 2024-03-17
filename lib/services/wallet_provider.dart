import 'package:bip32/bip32.dart' as bip32;
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  Future<String> generateMnemonic() async {
    return bip39.generateMnemonic();
  }

  Future<EthPrivateKey> createCredentials(String mnemonic) async {
    final privateKey = await _derivePrivateKey(mnemonic);
    return privateKey;
  }

  Future<List<String>> createMultipleCredentials(
      String mnemonic, int numAccounts) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final hdWallet = bip32.BIP32.fromSeed(seed);

    final List<String> accounts = [];
    for (int i = 0; i < numAccounts; i++) {
      final childKey = hdWallet.derivePath("m/44'/60'/$i'/0/0");
      final privateKeyHex = childKey.privateKey;
      final account = bytesToHex(privateKeyHex!);
      accounts.add(account);
    }

    return accounts;
  }

  Future<EthPrivateKey> _derivePrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final seedHex = bytesToHex(seed);
    final key = EthPrivateKey.fromHex(seedHex);

    return key;
    // final privateKeyHex = bytesToHex(key.privateKey);
    // return privateKeyHex;
  }

  String bytesToHex(Uint8List bytes) {
    final hexChars = List<String>.from(
      bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')),
    );
    return hexChars.join();
  }

  String privateKeyHex(EthPrivateKey key) {
    return bytesToHex(key.privateKey);
  }
}
