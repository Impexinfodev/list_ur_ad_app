class NotificationModel {
  bool? success;
  String? message;
  List<Data>? data;
  dynamic errorCode;
  dynamic errors;
  dynamic meta;

  NotificationModel({
    this.success,
    this.message,
    this.data,
    this.errorCode,
    this.errors,
    this.meta,
  });

  NotificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    errorCode = json['error_code'];
    errors = json['errors'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error_code'] = errorCode;
    data['errors'] = errors;
    data['meta'] = meta;
    return data;
  }
}

class Data {
  String? type;
  String? title;
  String? body;
  MetaData? metaData;
  bool? isRead;
  dynamic actionUrl;
  dynamic imageUrl;
  dynamic avatarUrl;
  String? id;
  String? userId;
  String? createdAt;

  Data({
    this.type,
    this.title,
    this.body,
    this.metaData,
    this.isRead,
    this.actionUrl,
    this.imageUrl,
    this.avatarUrl,
    this.id,
    this.userId,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    body = json['body'];
    metaData = json['meta_data'] != null ? MetaData.fromJson(json['meta_data']) : null;
    isRead = json['is_read'];
    actionUrl = json['action_url'];
    imageUrl = json['image_url'];
    avatarUrl = json['avatar_url'];
    id = json['id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['title'] = title;
    data['body'] = body;
    if (metaData != null) {
      data['meta_data'] = metaData!.toJson();
    }
    data['is_read'] = isRead;
    data['action_url'] = actionUrl;
    data['image_url'] = imageUrl;
    data['avatar_url'] = avatarUrl;
    data['id'] = id;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    return data;
  }
}

class MetaData {
  String? subtype;
  String? createdAt;
  String? ipAddress;
  String? userAgent;
  String? deviceName;

  MetaData({this.subtype, this.createdAt, this.ipAddress, this.userAgent, this.deviceName});

  MetaData.fromJson(Map<String, dynamic> json) {
    subtype = json['subtype'];
    createdAt = json['created_at'];
    ipAddress = json['ip_address'];
    userAgent = json['user_agent'];
    deviceName = json['device_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['subtype'] = subtype;
    data['created_at'] = createdAt;
    data['ip_address'] = ipAddress;
    data['user_agent'] = userAgent;
    data['device_name'] = deviceName;
    return data;
  }
}
