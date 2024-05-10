import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test1/app_router.dart';
import 'package:test1/constants/colors.dart';
import 'package:test1/constants/strings.dart';
import 'package:test1/constants/variables.dart';
import 'package:test1/data/web_services/auth_service.dart';
import 'package:test1/presentation/screens/home_screen_test.dart';
import 'package:test1/presentation/widgets/app_buttons.dart';
import 'package:test1/presentation/widgets/or_divider.dart';
import 'package:test1/presentation/widgets/text_field_widget.dart';

import '../../business_logic/cubit/auth_cubit.dart';
import '../../business_logic/cubit/auth_state.dart';
import '../../data/models/auth_models.dart';
import '../widgets/error_popup.dart';
import '../widgets/loading_indicator.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AppRouter appRouter = AppRouter();

  SharedPreferences? prefs;

  LoginScreen({super.key, this.prefs});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is AuthLoading) {
          // Show loading indicator
          showDialog(
            context: context,
            barrierDismissible: false, // Prevent dismiss by tapping outside
            builder: (context) => const LoadingIndicator(),
          );
        } else if (state is AuthAuthenticated) {
          // Navigate to authenticated screen
          Navigator.pushNamed(
            context,
            testScreen,
          );
        } else if (state is AuthError) {
          // Show error message

          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => ErrorPopup(
              errorMessage: state.message,
              onClose: () {
                Navigator.of(context).pop(); // Close the error popup
              },
            ),
          );
        }
      },
      builder: (context, state) {
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
                          'assets/images/Smart home-bro.png',
                        )),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: AppColors.highligtedTextColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
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
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () =>
                              Navigator.pushNamed(context, forgotPasswordV1),
                          child: const Column(
                            children: [
                              Text(
                                'Forgot your password?',
                                style: TextStyle(
                                  color: AppColors.highligtedTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: sizedBoxHeightSize,
                    ),
                    const SizedBox(
                      height: sizedBoxHeightSize,
                    ),
                    GestureDetector(
                      onTap: () {
                        LoginModel data = LoginModel(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        ApiServices(prefs: prefs).signinPostRequest(data);
                        BlocProvider.of<AuthCubit>(context).signIn(data);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const HomeScreenTest(),
                        //   ),
                        // );
                      },
                      child: MainAppButtons(
                        buttonColor: AppColors.mainButtonsColor,
                        borderColor: AppColors.mainButtonsBorderColor,
                        text: 'Sign in',
                        textColor: AppColors.mainButtonsTextColor,
                        key: key,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const OrDivider(),
                    const SizedBox(
                      height: 15,
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
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, signUpScreen);
                          },
                          child: const Text(
                            "Sign Up",
                            style:
                                TextStyle(color: AppColors.highligtedTextColor),
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
      },
    );
  }
}
