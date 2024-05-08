import 'package:flutter/material.dart';
import 'package:test1/app_router.dart';
import 'package:test1/login_screen.dart';
import 'package:test1/presentation/screens/signup_screen.dart';

import 'business_logic/cubit/auth_cubit.dart';
import 'data/web_services/auth_service.dart';
import 'presentation/screens/forget_password_v1_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    appRouter: AppRouter(),
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final SharedPreferences? prefs;
  const MyApp({super.key, required this.appRouter, this.prefs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(apiServices: ApiServices()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.generateRoute,
        // home: ForgotPasswordV1(),
      ),
    );
  }
}
