import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:list_ur_add/modules/notifications/model/notification_model.dart';
import 'package:list_ur_add/service/api_logs.dart';
import 'package:list_ur_add/service/api_service.dart';

class NotificationProvider with ChangeNotifier {
  List<Data> notifications = [];
  bool loading = false;
  int unreadCount = 0;

  Future<void> fetchNotifications() async {
    loading = true;
    notifyListeners();
    try {
      final response = await ApiService.notification();
      Log.console(response.body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List list = data['data'];
        notifications = list.map((e) => Data.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    loading = false;
    notifyListeners();
  }

  Future<void> readAllNotifications() async {
    try {
      final response = await ApiService.readAllNotification();
      Log.console("Read Notifications: ${response.body}");
      if (response.statusCode == 200) {
        unreadCount = 0;
        for (var n in notifications) {
          n.isRead = true;
        }
        notifyListeners();
      }
    } catch (e) {
      Log.console(e.toString());
    }
  }

  Future<void> getUnreadCount() async {
    try {
      final response = await ApiService.unreadCountNotification();
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        unreadCount = data["data"]["count"] ?? 0;
        notifyListeners();
      }
    } catch (e) {
      Log.console(e.toString());
    }
  }
}
