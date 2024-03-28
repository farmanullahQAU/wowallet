import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/services/storage_service.dart';
import 'package:wallet_app/views/bottom_navbar/controller.dart';
import 'package:wallet_app/views/home/view.dart';

class BottomNavbarView extends StatelessWidget {
  final controller = Get.put(BottomNavbarController());
  BottomNavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        children: [HomeView(), const Text("ss"), const Text("mmmmmmmmmmm")],
      ),
      bottomNavigationBar: GetBuilder<BottomNavbarController>(
          id: "navbar",
          builder: (_) {
            return NavigationBar(
              onDestinationSelected: controller.changePageIndex,
              indicatorColor: context.theme.colorScheme.primary,
              // backgroundColor: context.theme.colorScheme.background,
              // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              selectedIndex: controller.currentPageIndex,
              destinations: <Widget>[
                NavigationDestination(
                  icon: Badge(
                    label: Text(StorageService().addresses.length.toString()),
                    child: const Icon(Icons.account_balance_wallet_outlined),
                  ),
                  label: 'Assets',
                ),
                const NavigationDestination(
                  icon: Badge(
                    label: Text('2'),
                    child: Icon(Icons.data_thresholding_outlined),
                  ),
                  label: 'Transactions',
                ),
                const NavigationDestination(
                  icon: Icon(Icons.token),
                  label: 'Mint NFT',
                ),
              ],
            );
          }),
    );
  }
}
