import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remitance/src/common/widgets/app_dialoge.dart';
import 'package:remitance/src/core/routes/app_pages.dart';
import 'package:remitance/src/modules/Transaction/presentation/controller/home_controller.dart';
import 'package:remitance/src/modules/Transaction/presentation/widgets/custom_drawer.dart';
import 'package:remitance/src/modules/Transaction/presentation/widgets/transaction_list_tile.dart';
import 'package:remitance/src/utils/ext/color_extension.dart';
import 'package:remitance/src/utils/ext/text_style_extension.dart';

import '../../../../core/enum/box_types.dart';
import '../../../../core/resource/dimens.dart';
import '../widgets/balance_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        user: controller.user,
      ),
      appBar: AppBar(
        title: Text(
          'My Wallet',
          style: context.headlineLarge?.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () async {
              await DialogHelper.showConfirmationDialog(
                context: context,
                title: "Log out",
                content: "Are you sure you want to log out?", // ✅ Proper usage
                confirmText: "Yes",
                onConfirm: () {
                  Get.offAllNamed(AppRoutes.login);
                },
                onCancel: () {},
              );
            },
          ),
        ],
      ),
      body: PopScope(
        canPop: false,
        // ignore: deprecated_member_use
        onPopInvoked: (didPop) async {
          if (!didPop) {
            await DialogHelper.showConfirmationDialog(
              context: context,
              title: "Log out",
              content: "Are you sure you want to log out?",
              confirmText: "Yes",
              onConfirm: () {
                Get.offAllNamed(AppRoutes.login);
              },
              onCancel: () {}, // Optional
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(Dimens.space16),
            child: Column(
              children: [
                // Balance Card
                BalanceCard(
                  account: controller.hiveController.getBox(BoxType.account),
                  user: controller.user,
                ),
                SizedBox(height: Dimens.space24),

                // Quick Actions
                _buildQuickActions(),
                SizedBox(height: Dimens.space24),

                // Recent Transactions
                _buildRecentTransactions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildActionButton(
              icon: Icons.send,
              label: 'Send Money',
              color: Colors.blue,
              onpressed: () {
                Get.toNamed(AppRoutes.sendPage);
              },
            ),
            _buildActionButton(
              icon: Icons.qr_code,
              label: 'Scan QR',
              color: Colors.green,
              onpressed: () {},
            ),
            _buildActionButton(
              icon: Icons.currency_exchange,
              label: 'Exchange',
              color: Colors.orange,
              onpressed: () {
                Get.toNamed(AppRoutes.exchange);
              },
            ),
            _buildActionButton(
              icon: Icons.account_balance_wallet,
              label: 'Top Up',
              color: Colors.purple,
              onpressed: () {
                Get.toNamed(AppRoutes.topUp);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onpressed,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onpressed,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRecentTransactions(BuildContext context) {
    return Obx(() {
      final visibleCount = controller.visibleTransactionCount.value;

      final userTransactions = controller.transactions
          .where((transaction) =>
              transaction.currentUserEmail == controller.user.email ||
              transaction.receiverUserEmail == controller.user.email)
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));

      final displayedTransactions =
          userTransactions.take(visibleCount).toList();
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (userTransactions.isEmpty) {
        return Center(
          child: Text(
            "No Transaction is Done",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(Dimens.space24),
              if (userTransactions.length > 3)
                Center(
                  child: SizedBox(
                    height: Dimens.buttonH,
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(
                              context.secondary.withOpacity(0.4))),
                      onPressed: () =>
                          controller.toggleShowAll(userTransactions.length),
                      child: Center(
                        child: Text(
                          controller.visibleTransactionCount.value ==
                                  userTransactions.length
                              ? "Show Less"
                              : "Show More",
                          style: context.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          ValueListenableBuilder(
            valueListenable:
                controller.hiveController.transactionBox.listenable(),
            builder: (context, box, child) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedTransactions.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final transaction = userTransactions[index];

                  return TransactionListTile(
                      transaction: transaction, controller: controller);
                },
              );
            },
          ),
        ],
      );
    });
  }
}
