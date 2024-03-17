import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/services/storage_service.dart';
import 'package:wallet_app/views/home/view.dart';

class CongratView extends StatelessWidget {
  final controller = Get.put(StorageService());
  CongratView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: context.theme.colorScheme.background,
          radius: context.width * 0.1,
          child: const FlutterLogo(),
        ),
        Text(
          "Congratulation",
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        const Text("Congratulation you have successfully backup you wallet"),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: context.width * 0.7,
          height: 40,
          child: FilledButton(
            onPressed: () {
              Get.off(() => HomeView());
            },
            child: const Text('Done'),
          ),
        ),
      ],
    );
  }
}
