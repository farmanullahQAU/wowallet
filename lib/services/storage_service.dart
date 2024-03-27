import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet_app/style/constants.dart';

class StorageService extends GetxService {
  final box = GetStorage();
  Future _saveMnemonic(List<String>? mnemonic) async {
    box.write(mnomenicKey, mnemonic?.join(" "));
  }

  String? get getMnemonic => box.read(mnomenicKey);

  Future onSaveMnemonic(List<String>? mnemonic) async {
    await _saveMnemonic(mnemonic);
  }
}
