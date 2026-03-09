import 'package:flutter/material.dart';
import 'package:list_ur_add/modules/dashboard/views/dashboard_view.dart';
import 'package:list_ur_add/modules/language_selected/views/language_selected_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashProvider with ChangeNotifier {
  Future checkAuth(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");
    await Future.delayed(const Duration(seconds: 2));
    if (token != null && token.isNotEmpty) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const DashboardView(index: 0)),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LanguageSelectedView()),
        (route) => false,
      );
    }
  }
}
