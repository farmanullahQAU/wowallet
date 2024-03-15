import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

class WalletService {
  Future<String> generateMnemonic() async {
    return bip39.generateMnemonic();
  }

  Future<String> createCredentials(String mnemonic) async {
    final privateKeyHex = await _derivePrivateKey(mnemonic);
    return privateKeyHex;
  }

  Future<String> _derivePrivateKey(String mnemonic) async {
    final seed = bip39.mnemonicToSeed(mnemonic);
    final seedHex = bytesToHex(seed);
    final credentials = EthPrivateKey.fromHex(seedHex);
    final privateKeyHex = bytesToHex(credentials.privateKey);
    return privateKeyHex;
  }

  String bytesToHex(Uint8List bytes) {
    final hexChars = List<String>.from(
      bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')),
    );
    return hexChars.join();
  }
}
