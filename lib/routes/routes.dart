import 'package:flutter/material.dart';
import 'package:list_ur_add/modules/ad/views/ad_view.dart';
import 'package:list_ur_add/modules/ad/views/live_ad_view.dart';
import 'package:list_ur_add/modules/ad/views/payment_view.dart';
import 'package:list_ur_add/modules/ad/views/success_view.dart';
import 'package:list_ur_add/modules/advertisement/views/advertisement_view.dart';
import 'package:list_ur_add/modules/alert/views/alert_view.dart';
import 'package:list_ur_add/modules/archive/views/archive_view.dart';
import 'package:list_ur_add/modules/auth/views/language_selection_view.dart';
import 'package:list_ur_add/modules/auth/views/location_selection_view.dart';
import 'package:list_ur_add/modules/auth/views/login_view.dart';
import 'package:list_ur_add/modules/auth/views/otp_view.dart';
import 'package:list_ur_add/modules/cms/views/privacy_policy_view.dart';
import 'package:list_ur_add/modules/dashboard/views/dashboard_view.dart';
import 'package:list_ur_add/modules/gst_billing/views/gst_billing_view.dart';
import 'package:list_ur_add/modules/home/views/home_view.dart';
import 'package:list_ur_add/modules/inbox/views/chat_view.dart';
import 'package:list_ur_add/modules/language/views/language_view.dart';
import 'package:list_ur_add/modules/language_selected/provider/language_provider.dart';
import 'package:list_ur_add/modules/language_selected/views/language_selected_view.dart';
import 'package:list_ur_add/modules/payment/views/payment_history_view.dart';
import 'package:list_ur_add/modules/profile/views/profile_view.dart';
import 'package:list_ur_add/modules/setting/views/setting_view.dart';
import 'package:list_ur_add/modules/splash/views/splash_screen.dart';
import 'package:list_ur_add/modules/splash/views/splash_view.dart';
import 'package:list_ur_add/modules/splash/views/splash_view.dart';
import 'package:list_ur_add/modules/support/views/support_view.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String languageSelected = '/language-selected';
  static const String locationSelected = '/location-selected';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String advertisement = '/add_view';
  static const String languageSelection = '/language_selection_view';
  static const String dashboard = '/dashboard';
  static const String home = '/home';
  static const String policy = '/policy';
  static const String alert = '/alert';
  static const String paymentHistory = '/payment_history';
  static const String billing = '/gst_billing';
  static const String archive = '/archive';
  static const String chat = '/chat';
  static const String support = '/support';
  static const String setting = '/setting';
  static const String language = '/language';
  static const String ad = '/ad';
  static const String payment = '/payment';
  static const String success = '/success';
  static const String adLive = '/ad_live';
  static const String profile = '/profile';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (_) => const SplashView());

    case AppRoutes.languageSelected:
      return MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => LanguageProvider(),
          child: const LanguageSelectedView(),
        ),
      );

    case AppRoutes.login:
      return MaterialPageRoute(builder: (_) => LoginView());

    case AppRoutes.languageSelection:
      return MaterialPageRoute(builder: (_) => LanguageSelectionView());

    case AppRoutes.locationSelected:
      return MaterialPageRoute(builder: (_) => LocationSelectionView());

    case AppRoutes.advertisement:
      return MaterialPageRoute(builder: (_) => AdvertisementView());

    case AppRoutes.dashboard:
      return MaterialPageRoute(builder: (_) => DashboardView(index: 0));

    case AppRoutes.home:
      return MaterialPageRoute(builder: (_) => HomeView());

    case AppRoutes.policy:
      return MaterialPageRoute(builder: (_) => PrivacyPolicyView());

    case AppRoutes.alert:
      return MaterialPageRoute(builder: (_) => AlertView());

    case AppRoutes.paymentHistory:
      return MaterialPageRoute(builder: (_) => PaymentHistoryView());

    case AppRoutes.billing:
      return MaterialPageRoute(builder: (_) => GstBillingView());

    case AppRoutes.archive:
      return MaterialPageRoute(builder: (_) => ArchiveView());

    case AppRoutes.chat:
      return MaterialPageRoute(builder: (_) => ChatView());

    case AppRoutes.support:
      return MaterialPageRoute(builder: (_) => SupportView());

    case AppRoutes.setting:
      return MaterialPageRoute(builder: (_) => SettingView());

    case AppRoutes.language:
      return MaterialPageRoute(builder: (_) => LanguageView());

    case AppRoutes.ad:
      return MaterialPageRoute(builder: (_) => AdView());

    case AppRoutes.payment:
      return MaterialPageRoute(builder: (_) => PaymentView());

    case AppRoutes.success:
      return MaterialPageRoute(builder: (_) => SuccessView());

    case AppRoutes.adLive:
      return MaterialPageRoute(builder: (_) => LiveAdView());

    case AppRoutes.profile:
      return MaterialPageRoute(builder: (_) => ProfileView());

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(body: Center(child: Text('No route defined for this page'))),
      );
  }
}
