import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:remitance/src/common/widgets/custom_text_field.dart';
import 'package:remitance/src/core/resource/dimens.dart';
import 'package:remitance/src/utils/ext/common.dart';
import 'package:remitance/src/utils/ext/text_style_extension.dart';
import '../../../../core/resource/images.dart';
import '../../../../core/routes/app_pages.dart';
import '../controller/auth_controller.dart';
import '../widgets/custom_button.dart';

class SignupPage extends GetView<AuthController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Gap(Dimens.space50 + 25),
            Image.asset(
              Images.illustration1,
              height: Dimens.imageW + 80,
            ),
            Gap(Dimens.space50),
            Container(
              decoration: BoxDecoration(
                  color: context.primary,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimens.cornerRadiusBottomSheet),
                      topRight:
                          Radius.circular(Dimens.cornerRadiusBottomSheet))),
              height: Dimens.bottomSheetHeight,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.space24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Dimens.space24,
                    ),
                    Text(
                      "Hi Welcome!",
                      style: context.headlineMedium?.copyWith(
                        color: context.onPrimary,
                      ),
                    ),
                    Text(
                      "Are you a new user? please signup to continue",
                      style: context.bodyMedium?.copyWith(
                        color: context.onPrimary,
                      ),
                    ),
                    SizedBox(
                      height: Dimens.space24,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: context.onPrimary,
                            endIndent: 10,
                          ),
                        ),
                        Obx(
                          () => controller.isLoading.value == true
                              ? SizedBox(
                                  height: 14,
                                  width: 14,
                                  child: CircularProgressIndicator(
                                    color: context.onPrimary,
                                  ),
                                )
                              : Text(
                                  "Sign Up",
                                  style: context.headlineMedium?.copyWith(
                                    color: context.onPrimary,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: context.onPrimary,
                            indent: 10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimens.space24,
                    ),
                    Form(
                        child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Dimens.textFieldHeight,
                              child: CustomTextField(
                                labelText: "Full Name",
                                controller: controller.signupfullNameContoller,
                                fillColor: context.onPrimary.withOpacity(0.9),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: context.onPrimary.withOpacity(0.9),
                                )),
                              ),
                            ),
                            Gap(Dimens.space16),
                            SizedBox(
                              height: Dimens.textFieldHeight,
                              child: CustomTextField(
                                labelText: "Email",
                                controller: controller.signupEmailController,
                                labelWidget: Text("Email"),
                                fillColor: context.onPrimary.withOpacity(0.9),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: context.onPrimary.withOpacity(0.9),
                                )),
                              ),
                            ),
                            Gap(Dimens.space16),
                            SizedBox(
                              height: Dimens.textFieldHeight,
                              child: Obx(
                                () => CustomTextField(
                                  labelText: "Password",
                                  controller:
                                      controller.signupPasswordContoller,
                                  obscureText:
                                      !controller.isSignUpPassVisible.value,
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: context.iconColor,
                                    size: Dimens.space24,
                                  ),
                                  suffixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(right: Dimens.space12),
                                    child: IconButton(
                                      onPressed: () {
                                        controller.isSignUpPassVisible.toggle();
                                      },
                                      icon: Icon(
                                        controller.isSignUpPassVisible.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: context.iconColor,
                                        size: Dimens.space24,
                                      ),
                                    ),
                                  ),
                                  fillColor: context.onPrimary.withOpacity(0.9),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: context.onPrimary.withOpacity(0.9),
                                  )),
                                ),
                              ),
                            ),
                            Gap(Dimens.space16),
                            SizedBox(
                              height: Dimens.textFieldHeight,
                              child: Obx(
                                () => CustomTextField(
                                  labelText: "Confirm Password",
                                  controller:
                                      controller.signupConfirmPasswordContoller,
                                  obscureText:
                                      !controller.isSignUpConfVisible.value,
                                  prefixIcon: Icon(
                                    Icons.password,
                                    color: context.iconColor,
                                    size: Dimens.space24,
                                  ),
                                  suffixIcon: Padding(
                                    padding:
                                        EdgeInsets.only(right: Dimens.space12),
                                    child: IconButton(
                                      onPressed: () {
                                        controller.isSignUpConfVisible.toggle();
                                      },
                                      icon: Icon(
                                        controller.isSignUpConfVisible.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: context.iconColor,
                                        size: Dimens.space24,
                                      ),
                                    ),
                                  ),
                                  fillColor: context.onPrimary.withOpacity(0.9),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: context.onPrimary.withOpacity(0.9),
                                  )),
                                ),
                              ),
                            ),
                            Gap(Dimens.space30),
                            CustomButton(
                                buttonLabel: "Sign Up",
                                onPressed: () {
                                  controller.register(
                                      email: controller
                                          .signupEmailController.text
                                          .trim(),
                                      password: controller
                                          .signupPasswordContoller.text
                                          .trim(),
                                      confirmPassword: controller
                                          .signupPasswordContoller.text
                                          .trim(),
                                      name: controller
                                          .signupfullNameContoller.text
                                          .trim());
                                }),
                            Gap(Dimens.space24),
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: context.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "have an account? ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        )),
                                    TextSpan(
                                      text: "Login",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: context
                                            .onPrimary, // Use your primary color
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Get.toNamed(AppRoutes.login);
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
