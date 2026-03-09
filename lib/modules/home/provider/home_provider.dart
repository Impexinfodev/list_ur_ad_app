import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:list_ur_add/modules/home/model/ad_model.dart';
import 'package:list_ur_add/service/api_logs.dart';
import 'package:list_ur_add/service/api_service.dart';

class HomeProvider with ChangeNotifier {
  List<Ads> adsList = [];
  int totalLikes = 0;
  bool isLoading = false;

  Set<String> bookmarkedAds = {};

  Future<void> fetchAds() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await ApiService.getAds();
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        Log.console("Full Response: ${response.body}");
        AdModel model = AdModel.fromJson(decoded);
        adsList = model.data?.ads ?? [];
        Log.console("Ads Data: $adsList");
        Log.console("Total Ads: ${adsList.length}");
      } else {
        Log.console("API Error: ${response.statusCode}");
      }
    } catch (e) {
      Log.console("Error(fetchAds): $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchLikes() async {
    try {
      Log.console("Fetching likes...");
      final response = await ApiService.getLikes();
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        Log.console("Likes API Response: $decoded");
        if (decoded['success'] == true && decoded['data'] != null) {
          List<dynamic> likesData = decoded['data'];
          for (var adData in likesData) {
            final index = adsList.indexWhere((ad) => ad.id.toString() == adData['id'].toString());
            if (index != -1) {
              adsList[index].likesCount = adData['likes_count'] ?? 0;
              adsList[index].isLiked = adData['is_liked'] ?? false;
            }
          }
          totalLikes = adsList.fold(0, (sum, ad) => sum + (ad.likesCount ?? 0));
          Log.console("Total Likes: $totalLikes");
          notifyListeners();
        }
      } else {
        Log.console("Likes API Error: ${response.statusCode}");
      }
    } catch (e) {
      Log.console("Error(fetchLikes): $e");
    }
  }

  Future<void> toggleLike(String adId, int index) async {
    try {
      Ads ad = adsList[index];
      if (ad.isLiked == true) {
        ad.isLiked = false;
        ad.likesCount = (ad.likesCount ?? 1) - 1;
        notifyListeners();
        final response = await ApiService.unLikeAd(adId);
        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body);
          Log.console(decoded['message']);
        }
      } else {
        ad.isLiked = true;
        ad.likesCount = (ad.likesCount ?? 0) + 1;
        notifyListeners();
        final response = await ApiService.likeAd(adId);
        if (response.statusCode == 200) {
          final decoded = jsonDecode(response.body);
          Log.console(decoded['message']);
        }
      }
    } catch (e) {
      Log.console("Like Error: $e");
    }
  }

  Future<void> toggleBookmark(String adId) async {
    try {
      if (bookmarkedAds.contains(adId)) {
        bookmarkedAds.remove(adId);
        notifyListeners();

        await ApiService.unBookmarkAd(adId.toString());
      } else {
        bookmarkedAds.add(adId.toString());
        notifyListeners();

        await ApiService.bookmarkAd(adId.toString());
      }
    } catch (e) {
      Log.console("Bookmark Error: $e");
    }
  }

  Future<String?> toggleShare(String adId) async {
    try {
      final response = await ApiService.share(adId);
      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        Log.console('Ad shared successfully: $adId');
        return decoded['data']['url'];
      } else {
        Log.console('Failed to share ad: ${response.body}');
      }
    } catch (e) {
      Log.console('Share Error: $e');
    }
    return null;
  }
}
