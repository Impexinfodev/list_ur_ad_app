// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:list_ur_add/service/api_url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_client.dart';
import 'api_logs.dart';

class ApiService {
  static Future<String> getAccessToken() async {
    try {
      var instance = await SharedPreferences.getInstance();
      var token = instance.getString('access_token');
      Log.console("AccessToken$token");
      if (token == null) {
        return "";
      } else {
        return token;
      }
    } catch (e) {
      Log.console("Error(Function getAccessToken): $e");
      return '';
    }
  }

  ///registerApi
  static Future<http.Response> register({required Map<String, dynamic> body}) async {
    return await http.post(
      Uri.parse(ApiUrl.register),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
      body: jsonEncode(body),
    );
  }

  ///loginApi
  static Future<http.Response> login({
    required String verificationToken,
    required String phone,
    required String countryCode,
  }) async {
    return await http.post(
      Uri.parse(ApiUrl.login),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "country_code": countryCode,
        "verification_token": verificationToken,
      }),
    );
  }

  ///sendOtp
  static Future<http.Response> sendOtp({
    required String phone,
    required String countryCode,
    required String purpose,
  }) async {
    return await http.post(
      Uri.parse(ApiUrl.sendOtp),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
      body: jsonEncode({"phone": phone, "country_code": countryCode, "purpose": purpose}),
    );
  }

  ///loginApi
  static Future<http.Response> reSendOtp({
    required String phone,
    required String countryCode,
    required String purpose,
  }) async {
    return await http.post(
      Uri.parse(ApiUrl.reSendOtp),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
      body: jsonEncode({"phone": phone, "country_code": countryCode, "purpose": purpose}),
    );
  }

  /// otpVerifyApi
  static Future<http.Response> otpVerification({
    required String phone,
    required String countryCode,
    required String otp,
    required String purpose,
  }) async {
    return await http.post(
      Uri.parse(ApiUrl.verifyOtp),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "country_code": countryCode,
        "otp": otp,
        "purpose": purpose,
      }),
    );
  }

  ///loginApi
  static Future<http.Response> checkPhone({
    required String phone,
    required String countryCode,
  }) async {
    return await http.post(
      Uri.parse(ApiUrl.checkPhone),
      headers: {"Content-Type": "application/json", "Accept": "application/json0"},
      body: jsonEncode({"phone": phone, "country_code": countryCode}),
    );
  }

  ///languages
  static Future<http.Response> languages() async {
    return await http.get(
      Uri.parse(ApiUrl.languages),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
    );
  }

  ///locations
  static Future<http.Response> locations() async {
    return await http.get(
      Uri.parse(ApiUrl.locations),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
    );
  }

  ///categories
  static Future<http.Response> categories() async {
    return await http.get(
      Uri.parse(ApiUrl.categories),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
    );
  }

  ///subCategories
  static Future<http.Response> subCategories(String categoryId) async {
    return await http.get(
      Uri.parse(ApiUrl.subCategories(categoryId)),
      headers: {"Content-Type": "application/json", "Accept": "application/json"},
    );
  }

  /// ads
  static Future<http.Response> getAds() async {
    try {
      String token = await getAccessToken();
      return await http.get(
        Uri.parse(ApiUrl.ads),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      Log.console("Error(Function getTemplates): $e");
      rethrow;
    }
  }

  /// likes
  static Future<http.Response> getLikes() async {
    try {
      String token = await getAccessToken();
      return await http.get(
        Uri.parse(ApiUrl.likes),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
    } catch (e) {
      Log.console("Error(Function getTemplates): $e");
      rethrow;
    }
  }

  ///likeAd
  static Future<http.Response> likeAd(String adId) async {
    String token = await getAccessToken();
    return await http.post(
      Uri.parse(ApiUrl.likeAd(adId)),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  ///unLikeAd
  static Future<http.Response> unLikeAd(String adId) async {
    String token = await getAccessToken();
    return await http.delete(
      Uri.parse(ApiUrl.likeAd(adId)),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  ///bookmarkAd
  static Future<http.Response> bookmarkAd(String adId) async {
    String token = await getAccessToken();
    return await http.post(
      Uri.parse(ApiUrl.bookmarkAd(adId)),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  ///unBookmarkAd
  static Future<http.Response> unBookmarkAd(String adId) async {
    String token = await getAccessToken();
    return await http.post(
      Uri.parse(ApiUrl.bookmarkAd(adId)),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  ///share
  static Future<http.Response> share(String adId) async {
    String token = await getAccessToken();
    return await http.get(
      Uri.parse(ApiUrl.share(adId)),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }
}
