import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/views/home/controller.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // print(Get.find<WalletService>().privateKeyHex(controller.privateKey!));

    print(controller.privateKey?.address.toString() ?? "");

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  controller.initKey();
                },
                child: const Text("ss")),
            Text(controller.balance.toString() ?? ""),
            Text(controller.privateKey?.address.toString() ?? ""),
            CircleAvatar(
              backgroundColor: context.theme.colorScheme.background,
              radius: context.width * 0.1,
              child: const FlutterLogo(),
            ),
            Text(
              "Congratulation",
              style: context.textTheme.titleLarge,
            ),
            SizedBox(
              width: context.width * 0.7,
              height: 40,
              child: FilledButton(
                onPressed: () {},
                child: const Text('Done'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
