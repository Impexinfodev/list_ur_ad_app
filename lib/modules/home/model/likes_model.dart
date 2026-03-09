class LikesModel {
  bool? success;
  String? message;
  List<Data>? data;
  dynamic errorCode;
  dynamic errors;
  dynamic meta;

  LikesModel({this.success, this.message, this.data, this.errorCode, this.errors, this.meta});

  LikesModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? title;
  String? slug;
  String? status;
  String? userId;
  String? description;
  String? categoryId;
  dynamic categoryName;
  int? price;
  String? currency;
  String? priceType;
  String? city;
  bool? isPremium;
  bool? isFeatured;
  bool? isUrgent;
  int? viewsCount;
  int? favoritesCount;
  int? likesCount;
  bool? isLiked;
  String? createdAt;
  dynamic thumbnailUrl;
  dynamic ownerName;
  dynamic ownerAvatar;

  Data({
    this.id,
    this.title,
    this.slug,
    this.status,
    this.userId,
    this.description,
    this.categoryId,
    this.categoryName,
    this.price,
    this.currency,
    this.priceType,
    this.city,
    this.isPremium,
    this.isFeatured,
    this.isUrgent,
    this.viewsCount,
    this.favoritesCount,
    this.likesCount,
    this.isLiked,
    this.createdAt,
    this.thumbnailUrl,
    this.ownerName,
    this.ownerAvatar,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    status = json['status'];
    userId = json['user_id'];
    description = json['description'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    price = json['price'];
    currency = json['currency'];
    priceType = json['price_type'];
    city = json['city'];
    isPremium = json['is_premium'];
    isFeatured = json['is_featured'];
    isUrgent = json['is_urgent'];
    viewsCount = json['views_count'];
    favoritesCount = json['favorites_count'];
    likesCount = json['likes_count'];
    isLiked = json['is_liked'];
    createdAt = json['created_at'];
    thumbnailUrl = json['thumbnail_url'];
    ownerName = json['owner_name'];
    ownerAvatar = json['owner_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['status'] = status;
    data['user_id'] = userId;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['price'] = price;
    data['currency'] = currency;
    data['price_type'] = priceType;
    data['city'] = city;
    data['is_premium'] = isPremium;
    data['is_featured'] = isFeatured;
    data['is_urgent'] = isUrgent;
    data['views_count'] = viewsCount;
    data['favorites_count'] = favoritesCount;
    data['likes_count'] = likesCount;
    data['is_liked'] = isLiked;
    data['created_at'] = createdAt;
    data['thumbnail_url'] = thumbnailUrl;
    data['owner_name'] = ownerName;
    data['owner_avatar'] = ownerAvatar;
    return data;
  }
}
