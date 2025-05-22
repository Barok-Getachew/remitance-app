import 'package:flutter/material.dart';
import 'package:remitance/src/utils/ext/text_style_extension.dart';

class DialogHelper {
  static Future<void> showConfirmationDialog({
    required BuildContext context,
    required String title,
    String? content,
    Widget? contentWidget,
    String confirmText = "Confirm",
    String cancelText = "Cancel",
    Color? confirmButtonColor,
    Color? cancelButtonColor,
    bool barrierDismissible = true,
    bool showIcon = false,
    IconData icon = Icons.warning,
    Color iconColor = Colors.amber,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    VoidCallback? onDismiss,
  }) async {
    assert(content != null || contentWidget != null,
        "Either content or contentWidget must be provided");

    final theme = Theme.of(context);

    return await showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext dialogueContext) {
        return PopScope(
          canPop: barrierDismissible,
          onPopInvoked: (didPop) {
            if (didPop && onDismiss != null) {
              onDismiss();
            }
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showIcon)
                    Center(
                      child: Icon(
                        icon,
                        size: 48,
                        color: iconColor,
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  contentWidget ??
                      Text(
                        content!,
                        style: theme.textTheme.bodyMedium,
                      ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              cancelButtonColor ?? theme.colorScheme.error,
                        ),
                        child: Text(
                          cancelText,
                          style: context.headlineSmall?.copyWith(
                            color: cancelButtonColor ?? theme.colorScheme.error,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogueContext).pop();
                          onCancel?.call();
                        },
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        child: Text(
                          confirmText,
                          style: context.headlineMedium?.copyWith(
                            color:
                                cancelButtonColor ?? theme.colorScheme.primary,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogueContext).pop();
                          onConfirm();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
