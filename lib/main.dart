import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_ur_add/constant/app_colors.dart';
import 'package:list_ur_add/modules/auth/provider/auth_provider.dart';
import 'package:list_ur_add/modules/dashboard/provider/dashboard_provider.dart';
import 'package:list_ur_add/modules/home/provider/home_provider.dart';
import 'package:list_ur_add/modules/inbox/provider/chat_provider.dart';
import 'package:list_ur_add/modules/language_selected/provider/language_provider.dart';
import 'package:list_ur_add/modules/notifications/provider/notification_provider.dart';
import 'package:list_ur_add/modules/profile/provider/profile_provider.dart';
import 'package:list_ur_add/modules/splash/provider/splash_provider.dart';
import 'package:list_ur_add/modules/splash/views/splash_view.dart';
import 'package:list_ur_add/modules/support/provider/support_provider.dart';
import 'package:list_ur_add/routes/routes.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: false,
        useInheritedMediaQuery: true,
        child: SafeArea(
          top: false,
          left: false,
          right: false,
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => SplashProvider()),
              ChangeNotifierProvider(create: (_) => LanguageProvider()),
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => DashboardProvider()),
              ChangeNotifierProvider(create: (_) => HomeProvider()),
              ChangeNotifierProvider(create: (_) => ChatProvider()),
              ChangeNotifierProvider(create: (_) => SupportProvider()),
              ChangeNotifierProvider(create: (_) => NotificationProvider()),
              ChangeNotifierProvider(create: (_) => ProfileProvider()),
            ],
            child: MaterialApp(
              title: 'List Ur Ad',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.mainColor,
                ),
                useMaterial3: true,
              ),
              navigatorKey: Constants.navigatorKey,
              initialRoute: AppRoutes.splash,
              onGenerateRoute: generateRoute,
            ),
          ),
        ),
      ),
    );
  }
}

class Constants {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}