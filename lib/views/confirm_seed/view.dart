import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/views/confirm_seed/controller.dart';
import 'package:wallet_app/views/login/controller.dart';

class ConfirmSeedPage extends StatelessWidget {
  final controller = Get.put(ConfirmSeedController());
  ConfirmSeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(
          () => Container(
              margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
              padding: const EdgeInsets.all(16),
              width: context.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: controller.compareStringLists()
                    ? Border.all(color: Colors.green)
                    : Border.all(),
              ),
              child: GridView(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3,
                      crossAxisSpacing: 16,
                      crossAxisCount: 3,
                      mainAxisSpacing: 8),
                  children: List.generate(
                      controller.selectedSeeds.length,
                      (index) => InkWell(
                            onTap: () => controller.onTapChip(index),
                            child: Container(
                              width: context.width * 0.2,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: controller
                                          .selectedSeeds[index].isNotEmpty
                                      ? Border.all(
                                          width: 0.5,
                                          color:
                                              context.theme.colorScheme.primary)
                                      : index == controller.currentIndex
                                          ? Border.all(
                                              width: 0.3,
                                              color: context
                                                  .theme.colorScheme.outline)
                                          : Border.all(width: 0.3)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("${index + 1}. ",
                                      style: context.textTheme.labelMedium
                                          ?.copyWith(
                                              color: context
                                                  .theme.colorScheme.primary)),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(controller.selectedSeeds[index]),
                                ],
                              ),
                            ),
                          )))),
        ),
        Obx(() {
          const itemsPerRow = 3;
          final rows = (controller.shufflePhrase.length / itemsPerRow).ceil();

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(16)),
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                itemCount: rows,
                itemBuilder: (context, index) {
                  int startIndex = index * itemsPerRow;
                  int endIndex = startIndex + itemsPerRow;
                  if (endIndex > controller.shufflePhrase.length) {
                    endIndex = controller.shufflePhrase.length;
                  }
                  final list =
                      controller.shufflePhrase.sublist(startIndex, endIndex);
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: list
                          .map((e) => InkWell(
                                borderRadius: BorderRadius.circular(16),
                                onTap: () => controller.onTapValue(
                                  e,
                                ),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  width: context.width * 0.2,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: e["isSelected"]
                                          ? context.theme.colorScheme.primary
                                              .withOpacity(0.3)
                                          : null,
                                      borderRadius: BorderRadius.circular(25),
                                      border: e["isSelected"]
                                          ? Border.all(
                                              width: 0.3,
                                              color: context
                                                  .theme.colorScheme.outline)
                                          : Border.all(width: 0.3)),
                                  child: Center(child: Text(e["value"])),
                                ),
                              ))
                          .toList(),
                    ),
                  );
                }),
          );
        }),
        SizedBox(
          width: context.width * 0.7,
          height: 40,
          child: FilledButton(
            onPressed: () => Get.find<LoginController>().toNextStep(3),
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}
