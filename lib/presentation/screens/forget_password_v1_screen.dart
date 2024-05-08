import 'package:flutter/material.dart';
import 'package:test1/constants/colors.dart';
import '../../data/models/auth_models.dart';
import '../../data/web_services/auth_service.dart';
import '../widgets/app_buttons.dart';
import '../widgets/text_field_widget.dart';

// ignore: must_be_immutable
class ForgetPasswordV1 extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  ForgetPasswordV1({super.key});

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
                      'Forgot your password?',
                      style: TextStyle(
                          color: AppColors.highligtedTextColor,
                          fontSize: 28,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Please, enter your email address to reset your password.',
                  style:
                      TextStyle(fontSize: 18, color: AppColors.textTypingColor),
                ),
                const SizedBox(height: 40),
                MainAppTextField(
                  controller: emailController,
                  textFieldColor: AppColors.textFieldColor,
                  borderColor: AppColors.textFieldColor,
                  text: 'Email',
                  textColor: AppColors.textFieldTextColor,
                  isIcon: true,
                  iconAssetPath: 'assets/icons/icons8-email-24.png',
                  textTypingColor: AppColors.textTypingColor,
                ),
                const SizedBox(height: 140),
                GestureDetector(
                  onTap: () {
                    ForgetPasswordModel data = ForgetPasswordModel(
                      email: emailController.text,
                    );
                    ApiServices().forgetPasswordPostRequest(data);
                  },
                  child: MainAppButtons(
                    buttonColor: AppColors.mainButtonsColor,
                    borderColor: AppColors.mainButtonsBorderColor,
                    text: 'Continue',
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
