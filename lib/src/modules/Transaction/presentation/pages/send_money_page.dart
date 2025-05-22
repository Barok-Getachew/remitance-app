import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remitance/src/modules/Transaction/presentation/controller/home_controller.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../widgets/loading_button.dart';

class SendMoneyScreen extends GetView<HomeController> {
  SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount Input
                  CustomTextField(
                    labelText: 'Amount (ETB)',
                    prefixText: 'ETB ',
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) {
                      controller.sendAmount.value =
                          double.tryParse(value) ?? 0.0;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter amount';
                      }
                      if ((double.tryParse(value) ?? 0) <= 0) {
                        return 'Amount must be greater than 0';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Recipient Email
                  CustomTextField(
                    labelText: 'Recipient Email',
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => controller.receiverEmail.text = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter recipient email';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Payment Source Dropdown
                  // InputDecorator(
                  //   decoration: InputDecoration(
                  //     labelText: 'Payment Source',
                  //     border: OutlineInputBorder(),
                  //     contentPadding:
                  //         EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  //   ),
                  //   child: DropdownButtonHideUnderline(
                  //     child: DropdownButton<String>(
                  //       value: controller.selectedSource.value.isNotEmpty
                  //           ? controller.selectedSource.value
                  //           : null,
                  //       isExpanded: true,
                  //       hint: const Text('Select payment source'),
                  //       items: controller.paymentSources.map((source) {
                  //         return DropdownMenuItem<String>(
                  //           value: source,
                  //           child: Text(source),
                  //         );
                  //       }).toList(),
                  //       onChanged: (value) {
                  //         controller.selectedSource.value = value ?? '';
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 20),

                  // Description (Optional)
                  CustomTextField(
                    labelText: 'Description (Optional)',
                    onChanged: (value) => controller.description.value = value,
                  ),
                  const SizedBox(height: 30),

                  // Send Button
                  LoadingButton(
                    isLoading: controller.isLoading.value,
                    onPressed: () async {
                      await controller.submitSendMoneyTransaction();
                    },
                    text: 'Send Money',
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
