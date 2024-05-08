import 'package:flutter/material.dart';
import 'package:test1/presentation/screens/forget_password_v1_screen.dart';
import 'package:test1/presentation/screens/home_screen_test.dart';
import 'package:test1/presentation/screens/login_screen.dart';
import 'package:test1/signup_ui.dart';

import 'constants/strings.dart';
import 'presentation/screens/forget_password_v2_screen.dart';
import 'presentation/screens/forget_password_v3_screen.dart';
import 'presentation/screens/signup_screen.dart';
import 'presentation/screens/test_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case loginScreen:
      // return MaterialPageRoute(builder: (_) => ForgetPasswordV2());
      // case loginScreen:
      // return MaterialPageRoute(builder: (_) => HomeScreenTest());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case forgotPasswordV1:
        return MaterialPageRoute(builder: (_) => ForgetPasswordV1());

      case forgotPasswordV2:
        return MaterialPageRoute(builder: (_) => ForgetPasswordV2());

      case forgotPasswordV3:
        return MaterialPageRoute(builder: (_) => ForgetPasswordV3());

      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());

      case testScreen:
        return MaterialPageRoute(builder: (_) => HomeScreenTest());

      // case loginScreen:
      // return MaterialPageRoute(builder: (_) => const TestScreen());
    }
  }
}
