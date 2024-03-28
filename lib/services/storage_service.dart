import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet_app/style/constants.dart';

class StorageService extends GetxService {
  static final StorageService _instance = StorageService._internal();

  factory StorageService() {
    return _instance;
  }

  StorageService._internal();

  final RxList<String> addresses = <String>[].obs;
  final box = GetStorage();

  Future<void> init() async {
    final List<dynamic> data = box.read(accountsKey);
    addresses.assignAll(data.map((item) => item.toString()));
  }

  Future<void> _saveMnemonic(List<String>? mnemonic) async {
    await box.write(mnomenicKey, mnemonic?.join(" "));
  }

  String? get getMnemonic => box.read(mnomenicKey);

  Future<void> onSaveMnemonic(List<String>? mnemonic) async {
    await _saveMnemonic(mnemonic);
  }

  Future<void> _savePrivateKey(String key) async {
    addresses.add(key);
    await box.write(accountsKey, addresses.toList());
  }

  Future<void> onRemoveAccount(String value) async {
    addresses.remove(value);
    await box.write(accountsKey, addresses.toList());
  }

  Future<void> onSavePrivateKey(String key) async {
    await _savePrivateKey(key);
  }
}
