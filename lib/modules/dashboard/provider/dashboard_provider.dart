import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:list_ur_add/modules/dashboard/model/subcategory_model.dart';
import 'package:list_ur_add/modules/dashboard/model/category_model.dart';
import 'package:list_ur_add/modules/home/views/home_view.dart';
import 'package:list_ur_add/modules/inbox/views/inbox_view.dart';
import 'package:list_ur_add/modules/market/views/market_view.dart';
import 'package:list_ur_add/modules/notifications/views/notification_view.dart';
import 'package:list_ur_add/service/api_logs.dart';
import 'package:list_ur_add/service/api_service.dart';

class DashboardProvider with ChangeNotifier {
  int selectedIndex = 0;
  String? selectedCategory;
  bool isLoading = false;
  bool isSubLoading = false;
  String error = '';
  List<CategoryModel> categories = [];
  List<SubCategoryModel> subCategories = [];

  Future<void> fetchCategories() async {
    isLoading = true;
    error = '';
    notifyListeners();
    try {
      final response = await ApiService.categories();
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['success'] == true) {
          List data = decoded['data']['categories'];
          Log.console(data);
          categories = data.map((e) => CategoryModel.fromJson(e)).toList();
        } else {
          error = decoded['message'] ?? "Something went wrong";
        }
      } else {
        error = "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  void setSelectedCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  Future<void> fetchSubCategories(String categoryId) async {
    isSubLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.subCategories(categoryId);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['success'] == true) {
          List data = decoded['data']['subcategories'];
          Log.console(data);
          subCategories = data.map((e) => SubCategoryModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      debugPrint("SubCategory Error: $e");
    }
    isSubLoading = false;
    notifyListeners();
  }

  final List<Widget> pages = [const HomeView(), InboxView(), MarketView(), NotificationView()];

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
