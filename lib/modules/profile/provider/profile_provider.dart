import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:list_ur_add/modules/profile/model/profile_model.dart';
import 'package:list_ur_add/modules/profile/model/suggestions_model.dart';
import 'package:list_ur_add/service/api_service.dart';
import 'package:list_ur_add/service/api_logs.dart';

class ProfileProvider with ChangeNotifier {
  ProfileModel? profileModel;
  List<Items> suggestionsList = [];
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

  Future<bool> updateProfile(Map<String, dynamic> body) async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.updateProfile(body);
      Log.console("Update Profile Response : ${response.body}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        profileModel = ProfileModel.fromJson(data);
        isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      Log.console("Update Profile Error : $e");
    }

    isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> uploadProfileImage(File file) async {
    try {
      await ApiService.uploadProfileImage(file);
      await fetchProfile();
    } catch (e) {
      Log.console("Upload Profile Image Error: $e");
    }
  }

  Future<void> uploadCoverImage(File file) async {
    try {
      await ApiService.uploadCoverImage(file);
      await fetchProfile();
    } catch (e) {
      Log.console("Upload Cover Image Error: $e");
    }
  }

  Future<void> getSuggestions() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.suggestions();
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        SuggestionsModel model = SuggestionsModel.fromJson(decoded);
        suggestionsList = model.data?.items ?? [];
      } else {
        suggestionsList = [];
      }
    } catch (e) {
      suggestionsList = [];
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  void removeSuggestion(int index) {
    suggestionsList.removeAt(index);
    notifyListeners();
  }

  Future<void> refreshProfile() async {
    await fetchProfile();
  }
}
