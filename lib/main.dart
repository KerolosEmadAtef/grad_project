import 'package:flutter/material.dart';
import 'package:test1/app_router.dart';
import 'package:test1/constants/cache_helper.dart';

import 'business_logic/cubit/auth_cubit.dart';
import 'data/web_services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.int();
  runApp(MyApp(
    appRouter: AppRouter(),
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
      child: ScreenUtilInit(
        designSize: const Size(356, 722),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute,
          // home: ForgotPasswordV1(),
        ),
      ),
    );
  }
}
