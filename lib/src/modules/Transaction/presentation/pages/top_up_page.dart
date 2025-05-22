import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remitance/src/common/widgets/custom_text_field.dart';
import 'package:remitance/src/modules/Transaction/presentation/controller/home_controller.dart';
import '../../../../core/enum/transaction_type.dart';

class TopUpScreen extends GetView<HomeController> {
  TopUpScreen({super.key}) {
    controller.selectedType.value = TransactionType.topup;
    controller.fetchPaymentMethods(); // Add this method to your controller
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up Wallet'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoadingPaymentMethods.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              // Amount Input
              CustomTextField(
                labelText: 'Amount',
                prefixText: '\$ ',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.topupAmount.value = double.tryParse(value) ?? 0.0;
                },
              ),
              const SizedBox(height: 20),

              // Payment Method Dropdown
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Payment Method',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedPaymentMethod.value.isNotEmpty
                        ? controller.selectedPaymentMethod.value
                        : null,
                    isExpanded: true,
                    hint: const Text('Select payment method'),
                    items: controller.paymentMethods.map((method) {
                      return DropdownMenuItem<String>(
                        value: method.id,
                        child: Row(
                          children: [
                            Icon(_getPaymentMethodIcon(method.type.toString())),
                            const SizedBox(width: 10),
                            Text(method.name),
                            if (method.lastFourDigits.isNotEmpty)
                              Text(' •••• ${method.lastFourDigits}'),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      controller.selectedPaymentMethod.value = value ?? '';
                      controller.topUpsource.value = value ?? '';
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                    border: OutlineInputBorder()),
                onChanged: (value) => controller.description.value = value,
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          if (controller.selectedPaymentMethod.value.isEmpty) {
                            Get.snackbar(
                                'Error', 'Please select a payment method');
                            return;
                          }
                          await controller.submitTransaction();
                        },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Top Up Now',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  IconData _getPaymentMethodIcon(String type) {
    switch (type.toLowerCase()) {
      case 'bank':
        return Icons.account_balance;
      case 'card':
        return Icons.credit_card;
      case 'mobile money':
        return Icons.phone_android;
      default:
        return Icons.payment;
    }
  }
}
