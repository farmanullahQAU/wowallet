import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
      
      title: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("TOTAL BALANCE"),
            Text(
              "${controller.balance?.getValueInUnit(EtherUnit.ether)} ETH",
              style: context.textTheme.titleMedium,
            ),

      
      
          ],
        ),
              centerTitle: true,
      
              pinned: true,
              // pinned: _pinned,
              // snap: _snap,
              // floating: _floating,
              expandedHeight: 170.0,
      
              bottom: PreferredSize(preferredSize: Size.fromHeight(kToolbarHeight), child:   Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          child: Icon(Icons.minimize),
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
                          radius: 15,
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
                          radius: 15,
                          child: Icon(Icons.send),
                        ),
                        Text(
                          "Deposit",
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                        ),
                        Text(
                          "Withdraw",
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              )
              ),
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
                 child: FlutterLogo(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: Text('Scroll to see the SliverAppBar in effect.'),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child:
                          Text('$index', textScaler: const TextScaler.linear(5)),
                    ),
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: controller.changePageIndex,
          indicatorColor: context.theme.colorScheme.primary,
          // backgroundColor: context.theme.colorScheme.background,
          // labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: controller.currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Badge(
                label: Text('2'),
                child: Icon(Icons.person),
              ),
              label: 'Profile',
            ),
            NavigationDestination(
              icon: Icon(Icons.token),
              label: 'Mint NFT',
            ),
          ],
        ),
      ),
    );
  }
}
