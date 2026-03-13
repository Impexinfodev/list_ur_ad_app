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

  bool isLoading = false;
  bool isSubLoading = false;

  List<CategoryModel> categories = [];

  List<List<SubCategoryModel>> categoryLevels = [];

  List<String> selectedLevels = [];

  String error = '';

  Future<void> fetchCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService.categories();

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded['success'] == true) {
          List data = decoded['data']['categories'];

          categories = data.map((e) => CategoryModel.fromJson(e)).toList();
        }
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  void selectCategory(CategoryModel category) {
    selectedLevels = [category.name];

    categoryLevels.clear();

    fetchSubCategories(category.id, 0);

    notifyListeners();
  }

  Future<void> fetchSubCategories(String parentId, int level) async {
    isSubLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.subCategories(parentId);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded['success'] == true) {
          List data = decoded['data']['subcategories'];
          List<SubCategoryModel> sub = data.map((e) => SubCategoryModel.fromJson(e)).toList();
          if (categoryLevels.length > level) {
            categoryLevels = categoryLevels.sublist(0, level);
          }
          if (sub.isNotEmpty) {
            categoryLevels.add(sub);
          }
        }
      }
    } catch (e) {
      Log.console(e);
    }
    isSubLoading = false;
    notifyListeners();
  }

  void selectSubCategory(SubCategoryModel sub, int level) {
    if (selectedLevels.length > level + 1) {
      selectedLevels = selectedLevels.sublist(0, level + 1);
    }
    selectedLevels.add(sub.name);
    fetchSubCategories(sub.id, level + 1);
    notifyListeners();
  }

  final List<Widget> pages = [const HomeView(), InboxView(), MarketView(), NotificationView()];

  void onItemTapped(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
