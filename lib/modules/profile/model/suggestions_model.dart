class SuggestionsModel {
  bool? success;
  String? message;
  Data? data;
  dynamic errorCode;
  dynamic errors;
  dynamic meta;

  SuggestionsModel({this.success, this.message, this.data, this.errorCode, this.errors, this.meta});

  SuggestionsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errorCode = json['error_code'];
    errors = json['errors'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};

    dataMap['success'] = success;
    dataMap['message'] = message;

    if (data != null) {
      dataMap['data'] = data!.toJson();
    }

    dataMap['error_code'] = errorCode;
    dataMap['errors'] = errors;
    dataMap['meta'] = meta;

    return dataMap;
  }
}

class Data {
  List<Items>? items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = List<Items>.from(json['items'].map((v) => Items.fromJson(v)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};

    if (items != null) {
      dataMap['items'] = items!.map((v) => v.toJson()).toList();
    }

    return dataMap;
  }
}

class Items {
  String? id;
  String? fullName;
  String? username;
  String? avatarUrl;
  String? bio;
  String? city;
  int? mutualFollowersCount;
  String? reason;

  Items({
    this.id,
    this.fullName,
    this.username,
    this.avatarUrl,
    this.bio,
    this.city,
    this.mutualFollowersCount,
    this.reason,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    username = json['username'];
    avatarUrl = json['avatar_url'];
    bio = json['bio'];
    city = json['city'];
    mutualFollowersCount = json['mutual_followers_count'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};

    dataMap['id'] = id;
    dataMap['full_name'] = fullName;
    dataMap['username'] = username;
    dataMap['avatar_url'] = avatarUrl;
    dataMap['bio'] = bio;
    dataMap['city'] = city;
    dataMap['mutual_followers_count'] = mutualFollowersCount;
    dataMap['reason'] = reason;

    return dataMap;
  }
}
