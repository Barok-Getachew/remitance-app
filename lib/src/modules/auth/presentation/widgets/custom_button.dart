import 'package:flutter/material.dart';
import 'package:remitance/src/utils/ext/common.dart';

import '../../../../core/resource/dimens.dart';

class CustomButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback onPressed;
  const CustomButton(
      {super.key, required this.buttonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: Dimens.buttonH + 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.cornerRadius - 3),
          color: context.secondary,
        ),
        child: Center(
          child: Text(
            buttonLabel,
            style: context.headlineMedium?.copyWith(
              color: context.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
