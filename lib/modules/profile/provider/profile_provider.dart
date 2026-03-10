import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:list_ur_add/modules/profile/model/profile_model.dart';
import 'package:list_ur_add/service/api_service.dart';
import 'package:list_ur_add/service/api_logs.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? profileModel;

  bool isLoading = false;

  Future<void> fetchProfile() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.getProfile();
      Log.console("Profile Response : ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        profileModel = ProfileModel.fromJson(data);
      }
    } catch (e) {
      Log.console("Profile Error : $e");
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> refreshProfile() async {
    await fetchProfile();
  }
}
