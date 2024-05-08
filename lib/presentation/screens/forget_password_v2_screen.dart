import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test1/presentation/screens/forget_password_v3_screen.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../data/models/auth_models.dart';
import '../../data/web_services/auth_service.dart';
import '../widgets/app_buttons.dart';
import '../widgets/text_field_widget.dart';

class ForgetPasswordV2 extends StatelessWidget {
  String? resetToken;
  TextEditingController tokenController = TextEditingController();
  ForgetPasswordV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.highligtedTextColor,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Enter Verification Code',
                      style: TextStyle(
                          color: AppColors.highligtedTextColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      'We have sent a code to your email.',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.textTypingColor),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                MainAppTextField(
                  controller: tokenController,
                  textFieldColor: AppColors.textFieldColor,
                  borderColor: AppColors.textFieldColor,
                  text: 'Enter your code',
                  textColor: AppColors.textFieldTextColor,
                  isIcon: true,
                  iconAssetPath: 'assets/icons/icons8-email-24.png',
                  textTypingColor: AppColors.textTypingColor,
                ),
                const SizedBox(height: 140),
                GestureDetector(
                  onTap: () {
                    resetToken = tokenController.text;
                    print(resetToken);
                    // if (resetToken != null) {
                    //   Navigator.pushNamed(context, forgotPasswordV3);
                    // }
                    if (resetToken != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ForgetPasswordV3(resetToken: resetToken!),
                        ),
                      );
                    }
                  },
                  child: MainAppButtons(
                    buttonColor: AppColors.mainButtonsColor,
                    borderColor: AppColors.mainButtonsBorderColor,
                    text: 'Verify Now',
                    textColor: AppColors.mainButtonsTextColor,
                    key: key,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
