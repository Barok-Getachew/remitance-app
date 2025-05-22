import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remitance/src/modules/auth/domain/entity/user_entity.dart';
import 'package:remitance/src/utils/ext/common.dart';
import 'package:remitance/src/utils/helper/string_obfuscate.dart';

import '../../../../core/resource/dimens.dart';

class BalanceCard extends StatelessWidget {
  final UserEntity user;
  final Box account;
  const BalanceCard({
    super.key,
    required this.user,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [context.primary.withOpacity(0.7), context.primary],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Current Balance',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            ValueListenableBuilder<Box>(
              valueListenable: account.listenable(
                keys: [user.email],
              ),
              builder: (context, box, child) {
                final userMap = box.get(user.email);

                final balance = userMap?['balance'] ?? 0;
                return Text("ETB ${balance.toString()}",
                    style: context.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ));
              },
            ),
            SizedBox(height: Dimens.space24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringHelper.obfuscateEmail(user.email),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    letterSpacing: 1.5,
                  ),
                ),
                Icon(
                  Icons.payment_rounded,
                  color: context.onPrimary,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Text(
                  '12/25',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
