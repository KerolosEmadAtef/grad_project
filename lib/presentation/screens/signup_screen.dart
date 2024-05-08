import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test1/constants/colors.dart';
import 'package:test1/data/models/auth_models.dart';
import 'package:test1/presentation/widgets/or_divider.dart';
import 'package:test1/presentation/widgets/text_field_widget.dart';

import '../../constants/strings.dart';
import '../../constants/variables.dart';
import '../../data/web_services/auth_service.dart';
import '../widgets/app_buttons.dart';

class SignupScreen extends StatelessWidget {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Image(
                    height: imageHeight,
                    width: imageWidth,
                    image: AssetImage(
                      'assets/images/Smart home-rafiki.png',
                    )),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Create New Account',
                      style: TextStyle(
                          color: AppColors.highligtedTextColor,
                          fontSize: highligtedTextSize,
                          fontWeight: FontWeight.w900),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                MainAppTextField(
                  controller: userNameController,
                  textFieldColor: AppColors.textFieldColor,
                  borderColor: AppColors.textFieldColor,
                  text: 'Username',
                  textColor: AppColors.textFieldTextColor,
                  textTypingColor: AppColors.textTypingColor,
                  isIcon: true,
                  defaultIcon: Icons.person_outline_rounded,
                ),
                const SizedBox(
                  height: sizedBoxHeightSize,
                ),
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
                const SizedBox(
                  height: sizedBoxHeightSize,
                ),
                MainAppTextField(
                  controller: passwordController,
                  onSuffixTap: () {},
                  obscureText: true,
                  textFieldColor: AppColors.textFieldColor,
                  borderColor: AppColors.textFieldColor,
                  text: 'Password',
                  textColor: AppColors.textFieldTextColor,
                  isIcon: true,
                  iconAssetPath: 'assets/icons/icons8-password-24.png',
                  textTypingColor: AppColors.textTypingColor,
                ),
                const SizedBox(
                  height: sizedBoxHeightSize,
                ),
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
                const SizedBox(
                  height: sizedBoxHeightSize * 2,
                ),
                GestureDetector(
                  onTap: () {
                    SignupModel data = SignupModel(
                      userName: userNameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    ApiServices().signupPostRequest(data);
                  },
                  child: MainAppButtons(
                    buttonColor: AppColors.mainButtonsColor,
                    borderColor: AppColors.mainButtonsBorderColor,
                    text: 'Sign Up',
                    textColor: AppColors.mainButtonsTextColor,
                    key: key,
                  ),
                ),
                const SizedBox(
                  height: sizedBoxHeightSize * 2,
                ),
                const OrDivider(),
                const SizedBox(
                  height: sizedBoxHeightSize * 2,
                ),
                MainAppButtons(
                    heightSize: 50,
                    textColor: Colors.black,
                    buttonColor: AppColors.backgroundColor,
                    borderColor: AppColors.highligtedTextColor,
                    text: 'Continue with Google',
                    isIcon: true,
                    icon: 'assets/icons/google.png'),
                const SizedBox(
                  height: sizedBoxHeightSize,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, loginScreen);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: AppColors.highligtedTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
