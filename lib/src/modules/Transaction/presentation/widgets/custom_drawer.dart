import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remitance/src/utils/ext/color_extension.dart';
import 'package:remitance/src/utils/helper/string_obfuscate.dart';

import '../../../../common/constants/keys.dart';
import '../../../../core/enum/box_types.dart';
import '../../../../core/routes/app_pages.dart';
import '../../../auth/domain/entity/user_entity.dart';

class CustomDrawer extends StatelessWidget {
  final UserEntity user;
  const CustomDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      child: Column(
        children: [
          // Header with user profile
          UserAccountsDrawerHeader(
            accountName: Text(
              user.name,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              StringHelper.obfuscateEmail(user.email),
              style:
                  theme.textTheme.bodyMedium?.copyWith(color: Colors.white70),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: theme.colorScheme.secondary,
              child: const Icon(Icons.person, size: 40),
            ),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
          ),

          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  leading: Icon(Icons.currency_exchange,
                      color: theme.colorScheme.onSurface),
                  title: Text(
                    'Exchange',
                    style: theme.textTheme.bodyLarge,
                  ),
                  onTap: () {
                    // Navigate to exchange
                    Get.toNamed(AppRoutes.exchange);
                  },
                ),
                const Divider(),
                ListTile(
                  leading: Icon(Icons.help, color: theme.colorScheme.onSurface),
                  title: Text(
                    'Help & Feedback',
                    style: theme.textTheme.bodyLarge,
                  ),
                  onTap: () {
                    // Navigate to help
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),

          // Theme toggle and footer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: Hive.box(BoxType.settings.name)
                      .listenable(keys: [biometricKey]),
                  builder: (context, Box box, _) {
                    final isBiometricEnabled =
                        box.get(biometricKey, defaultValue: false);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Biometric",
                          style: theme.textTheme.bodyLarge,
                        ),
                        Switch(
                          value: isBiometricEnabled,
                          onChanged: (value) async {
                            await box.put(biometricKey, value);
                          },
                        ),
                      ],
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: Hive.box(BoxType.settings.name)
                      .listenable(keys: [themeModeKey]),
                  builder: (context, Box box, _) {
                    final storedIndex = box.get(themeModeKey,
                        defaultValue: ThemeMode.light.index);
                    final currentThemeMode = ThemeMode.values[storedIndex];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Dark Mode',
                          style: theme.textTheme.bodyLarge,
                        ),
                        Switch(
                          value: currentThemeMode == ThemeMode.dark,
                          onChanged: (bool value) async {
                            final newThemeMode =
                                value ? ThemeMode.dark : ThemeMode.light;
                            await box.put(themeModeKey, newThemeMode.index);
                            // If your app has a theme manager, update it here
                          },
                          activeColor: context.secondary,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'App Version 1.0.0',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
