import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:remitance/src/app/page/my_app.dart';
import 'package:remitance/src/core/resource/dimens.dart';
import 'package:remitance/src/utils/ext/common.dart';

import '../../../../core/resource/images.dart';
import '../../domain/entity/exchange_entity.dart';
import '../controller/exchange_controller.dart';

class ExchangeView extends GetView<ExchangeController> {
  const ExchangeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Currency Exchange',
            style: context.headlineLarge?.copyWith(fontSize: 20),
          )),
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.availableCurrencies.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return _buildExchangeContent(context);
      }),
    );
  }

  Widget _buildExchangeContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Dimens.space16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Gap(Dimens.space36),
            SizedBox(
              height: 135.h,
              child: Image.asset(
                Images.exchangeIluustration,
              ),
            ),
            Gap(Dimens.space24),
            Text(
              textAlign: TextAlign.center,
              "Quickly convert amounts between currencies. Choose a currency and get real-time results — simple and to the point.",
              style: context.bodyMedium?.copyWith(
                  fontSize: Dimens.bodyMedium, fontWeight: FontWeight.w500),
            ),
            Gap(Dimens.space24),
            Column(
              children: [
                CurrencyRow(
                  label: 'From',
                  amount: controller.amount.value,
                  onAmountChanged: controller.updateAmount,
                  selectedCurrency: controller.fromCurrency.value,
                  onCurrencyChanged: controller.updateFromCurrency,
                  currencies: controller.availableCurrencies,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: context.primary, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: controller.swapCurrencies,
                    icon: Icon(
                      Icons.swap_vert,
                      color: context.onPrimary,
                    ),
                  ),
                ),
                CurrencyRow(
                  label: 'To',
                  amount: controller.convertedAmount.value,
                  onAmountChanged: null,
                  selectedCurrency: controller.toCurrency.value,
                  onCurrencyChanged: controller.updateToCurrency,
                  currencies: controller.availableCurrencies,
                ),
              ],
            ),
            // Error Message (if any)
            if (controller.error.value.isNotEmpty)
              Text(
                controller.error.value,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
          ],
        ),
      ),
    );
  }
}

class CurrencyRow extends StatefulWidget {
  final String label;
  final String amount;
  final ValueChanged<String>? onAmountChanged;
  final String selectedCurrency;
  final ValueChanged<String> onCurrencyChanged;
  final List<Currency> currencies;
  final bool isEnabled;

  const CurrencyRow({
    super.key,
    required this.label,
    required this.amount,
    this.onAmountChanged,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
    required this.currencies,
    this.isEnabled = true,
  });

  @override
  State<CurrencyRow> createState() => _CurrencyRowState();
}

class _CurrencyRowState extends State<CurrencyRow> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.amount);
  }

  @override
  void didUpdateWidget(CurrencyRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.amount != _controller.text) {
      _controller.text = widget.amount;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(Dimens.space16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: theme.dividerColor,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: theme.dividerColor,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: widget.isEnabled
                    ? theme.colorScheme.surface
                    : theme.disabledColor.withOpacity(0.1),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              controller: _controller,
              onChanged: widget.onAmountChanged,
              enabled: widget.isEnabled && widget.onAmountChanged != null,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 1,
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.dividerColor,
                  width: 1,
                ),
                color: widget.isEnabled
                    ? theme.colorScheme.surface
                    : theme.disabledColor.withOpacity(0.1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: widget.selectedCurrency,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: widget.isEnabled
                        ? theme.primaryColor
                        : theme.disabledColor,
                  ),
                  items: widget.currencies
                      .map((currency) => DropdownMenuItem(
                            value: currency.code,
                            child: Row(
                              children: [
                                Flag.fromString(
                                  currency.code.substring(0, 2),
                                  height: Dimens.space12,
                                  width: Dimens.space16,
                                  fit: BoxFit.fill,
                                ),
                                Gap(Dimens.space8),
                                Text(
                                  currency.code.toUpperCase(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                  onChanged: widget.isEnabled
                      ? (value) {
                          if (value != null) {
                            widget.onCurrencyChanged(value);
                          }
                        }
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
