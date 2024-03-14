import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "WOWALLET",
              style: context.theme.textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(() => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: loginController.steps.map((element) {
                    final index = loginController.steps.indexOf(element);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            loginController.toNextStep(index);
                          },
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: loginController.currentIndex.value ==
                                                index ||
                                            loginController.steps[index]
                                                    ["isDone"] ==
                                                true
                                        ? context.theme.colorScheme.primary
                                        : context.theme.primaryColorLight)),
                            child: Center(
                                child: Text(element["index"].toString())),
                          ),
                        ),
                        if (index < 2)
                          Container(
                              width: context.width * 0.2,
                              height: 2,
                              color: element["isDone"] == true
                                  ? context.theme.colorScheme.primary
                                  : context.theme.primaryColorLight)
                      ],
                    );
                  }).toList(),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              children: loginController.steps
                  .map((element) => Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Text(
                            element["title"],
                            style: context.textTheme.labelSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(() => TextField(
                  controller: loginController.usernameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'New Password',
                    errorText: loginController.errorText.value.isNotEmpty
                        ? loginController.errorText.value
                        : null,
                  ),
                )),
            const SizedBox(height: 20),
            Obx(() => TextField(
                  controller: loginController.passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    errorText: loginController.errorText.value.isNotEmpty
                        ? loginController.errorText.value
                        : null,
                  ),
                  obscureText: true,
                )),
            const SizedBox(height: 20),
            SizedBox(
              width: context.width * 0.7,
              height: 40,
              child: FilledButton(
                onPressed: loginController.login,
                child: Obx(
                  () => loginController.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
