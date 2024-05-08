import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../data/models/auth_models.dart';
import '../../data/web_services/auth_service.dart';
import '../widgets/app_buttons.dart';
import '../widgets/text_field_widget.dart';

class ForgetPasswordV3 extends StatelessWidget {
  String? resetToken;
  ForgetPasswordV3({super.key, this.resetToken});
  TextEditingController newPasswordController = TextEditingController();

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
                      'Reset Your Password',
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
                      'The password must be different than before',
                      style: TextStyle(
                          fontSize: 18, color: AppColors.textTypingColor),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                MainAppTextField(
                  controller: newPasswordController,
                  onSuffixTap: () {},
                  obscureText: true,
                  textFieldColor: AppColors.textFieldColor,
                  borderColor: AppColors.textFieldColor,
                  text: 'New Password',
                  textColor: AppColors.textFieldTextColor,
                  isIcon: true,
                  iconAssetPath: 'assets/icons/icons8-password-24.png',
                  textTypingColor: AppColors.textTypingColor,
                ),
                const SizedBox(height: 10),
                MainAppTextField(
                  onSuffixTap: () {},
                  obscureText: true,
                  textFieldColor: AppColors.textFieldColor,
                  borderColor: AppColors.textFieldColor,
                  text: 'Confirm Password',
                  textColor: AppColors.textFieldTextColor,
                  isIcon: true,
                  iconAssetPath: 'assets/icons/icons8-password-24.png',
                  textTypingColor: AppColors.textTypingColor,
                ),
                const SizedBox(height: 140),
                GestureDetector(
                  onTap: () {
                    ResetPasswordModel data = ResetPasswordModel(
                      password: newPasswordController.text,
                      token: resetToken,
                    );
                    ApiServices().resetPasswordPostRequest(data);
                  },
                  child: MainAppButtons(
                    buttonColor: AppColors.mainButtonsColor,
                    borderColor: AppColors.mainButtonsBorderColor,
                    text: 'Reset Password',
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
