import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/services/storage_service.dart';
import 'package:wallet_app/views/home/controller.dart';
import 'package:web3dart/web3dart.dart';

class HomeView extends StatelessWidget {
  final controller = Get.put(HomeController());
  HomeView({super.key});

// [SliverAppBar]s are typically used in [CustomScrollView.slivers], which in
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  actions: [
                    IconButton(
                        onPressed: controller.changeTheme,
                        icon: const Icon(Icons.brightness_3_outlined))
                  ],
                  title: TextButton.icon(
                    onPressed: controller.isShow.toggle,
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Address ${controller.accountIndex}"),
                        const Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                    icon: const CircleAvatar(
                      radius: 15,
                      child: Icon(
                        Icons.account_balance_wallet,
                        size: 10,
                      ),
                    ),
                  ),

                  pinned: true,
                  // pinned: _pinned,
                  // snap: _snap,
                  // floating: _floating,
                  expandedHeight: 200.0,
                  bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                const CircleAvatar(
                                  child: Center(child: Icon(Icons.remove)),
                                ),
                                Text(
                                  "Send",
                                  style: context.textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const CircleAvatar(
                                  child: Icon(Icons.add),
                                ),
                                Text(
                                  "Receive",
                                  style: context.textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const CircleAvatar(
                                  child: Icon(Icons.send),
                                ),
                                Text(
                                  "Swap",
                                  style: context.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  flexibleSpace: FlexibleSpaceBar(
                    // title: Column(

                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         Column(
                    //           children: [
                    //             const CircleAvatar(
                    //               radius: 15,
                    //             ),
                    //             Text(
                    //               "Deposit",
                    //               style: context.textTheme.bodySmall,
                    //             ),
                    //           ],
                    //         ),
                    //         const CircleAvatar(
                    //           child: Text("Send"),
                    //         ),
                    //         const CircleAvatar(
                    //           child: Text("Swap"),
                    //         ),
                    //         const CircleAvatar(
                    //           child: Text("Recevie"),
                    //         ),
                    //       ],
                    //     )
                    //   ],
                    // ),
                    background: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("TOTAL BALANCE"),
                          Text(
                            // "${controller.balance?.getValueInUnit(EtherUnit.ether)} ETH",
                            "",
                            style: context.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // SliverList(
                //   delegate: SliverChildBuilderDelegate(
                //     (BuildContext context, int index) {
                //       return Container(
                //         color: Colors.black12,
                //         height: 100.0,
                //         child: Center(
                //           child: Text('$index',
                //               textScaler: const TextScaler.linear(5)),
                //         ),
                //       );
                //     },
                //     childCount: 20,
                //   ),
                // ),
              ],
            ),
            Obx(
              () => controller.isShow.isFalse
                  ? const SizedBox()
                  : Positioned(
                      top: kToolbarHeight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.3),
                          borderRadius: BorderRadius.circular(16),
                          color: context.theme.canvasColor,
                        ),
                        width: Get.width * 0.8,
                        height: Get.height * 0.6,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Accounts"),
                                  Text(
                                    "Total 0.00 ETH",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: context
                                                .theme.colorScheme.primary),
                                  )
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 0.2,
                            ),
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children:
                                    StorageService().addresses.map((account) {
                                  final index = StorageService()
                                      .addresses
                                      .indexOf(account);
                                  return ListTile(
                                    onTap: () {
                                      controller.currentAccount = account;
                                      controller.isShow.toggle();
                                      controller.accountIndex = index + 1;
                                    },
                                    selectedColor:
                                        context.theme.colorScheme.primary,
                                    selected:
                                        controller.currentAccount == account,
                                    leading: const Icon(Icons.wallet),
                                    title: Text("Address ${index + 1}"),
                                    trailing:
                                        controller.currentAccount == account
                                            ? const Icon(Icons.check)
                                            : null,
                                    subtitle: FutureBuilder(
                                        future: controller.accountBalance(
                                            EthPrivateKey.fromHex(account)
                                                .address),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<EtherAmount>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "${snapshot.data!.getValueInUnit(EtherUnit.ether)} Ether",
                                              style: context.textTheme.bodySmall
                                                  ?.copyWith(
                                                      color: context
                                                          .theme.hintColor),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Text("Error");
                                          }

                                          return const Text("...");
                                        }),
                                  );
                                }).toList(),
                              ),
                            ),
                            FilledButton.icon(
                                style: FilledButton.styleFrom(
                                    fixedSize: Size.fromWidth(Get.width * 0.6),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.comfortable,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16)),
                                label: IconButton(
                                  style: IconButton.styleFrom(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.comfortable,
                                      padding: EdgeInsets.zero),
                                  onPressed: () {},
                                  icon: const Icon(Icons.settings),
                                ),
                                onPressed: controller.addAccount,
                                icon: const Text("Add new account"))
                          ],
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
