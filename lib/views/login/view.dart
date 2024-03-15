import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PageViewExampleState extends StatelessWidget {
  final loginController = Get.put(LoginController());
  PageViewExampleState({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(builder: (_) {
        return Stack(
          children: [
            PageView(
              controller: loginController.pageViewController,
              children: <Widget>[LoginPage(), RecoveryPhraseView()],
            ),
            Column(
              children: [
                Text(
                  "WOWALLET",
                  style: context.theme.textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 32,
                ),
                Obx(() => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: loginController.steps.map((element) {
                        final index = loginController.steps.indexOf(element);
                        var boxDecoration = BoxDecoration(
                            color: loginController.steps[index]["isDone"]
                                ? context.theme.colorScheme.primary
                                : null,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: loginController.currentIndex.value ==
                                            index ||
                                        loginController.steps[index]
                                                ["isDone"] ==
                                            true
                                    ? context.theme.colorScheme.primary
                                    : context.theme.primaryColorLight));
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: boxDecoration,
                              child: Center(
                                  child: Text(
                                element["index"].toString(),
                                style: context.textTheme.bodySmall,
                              )),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
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
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Text(
                "The password will unlock your wowallet only on this device",
                textAlign: TextAlign.center,
                style: context.textTheme.titleSmall,
              ),
            ),
            Obx(() => TextField(
                  controller: loginController.usernameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'New Password',
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
                    hintText: 'Confirm Password',
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
                      : const Text('Create Password'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecoveryPhraseView extends StatelessWidget {
  final loginController = Get.find<LoginController>();
  RecoveryPhraseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Write down your Secret Recovery Phrase",
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "This is your secret recovery phrase keep it safe. you have to re-enter on the next step.",
            style: context.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          Obx(
            () => loginController.phrase != null
                ? Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    width: context.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(),
                    ),
                    child: GridView(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 2, crossAxisCount: 3),
                        children: loginController.phrase!
                            .map((element) => Chip(label: Text(element)))
                            .toList()))
                : Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    width: context.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.visibility)),
                        const Text("Make sure no body is looking")
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: context.width * 0.7,
            height: 40,
            child: FilledButton(
              onPressed: () => loginController.createNewWallet(),
              child: const Text('Generate Phrase'),
            ),
          ),
        ],
      ),
    );
  }
}
