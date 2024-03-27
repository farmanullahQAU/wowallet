import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wallet_app/services/storage_service.dart';
import 'package:wallet_app/services/wallet_provider.dart';
import 'package:wallet_app/style/theme.dart';

import 'views/login/view.dart';

void main() async {
  await GetStorage.init();
  Get.put(StorageService());
  Get.put(WalletService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MetaMask Login',
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: ThemeMode.dark,
      home: MnomenicPhraseView(),
    );
  }
}
