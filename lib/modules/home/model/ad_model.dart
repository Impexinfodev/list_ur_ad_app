class AdModel {
  bool? success;
  String? message;
  AdsData? data;
  dynamic errorCode;
  dynamic errors;
  dynamic meta;

  AdModel({
    this.success,
    this.message,
    this.data,
    this.errorCode,
    this.errors,
    this.meta,
  });

  AdModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? AdsData.fromJson(json['data']) : null;
    errorCode = json['error_code'];
    errors = json['errors'];
    meta = json['meta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error_code'] = errorCode;
    data['errors'] = errors;
    data['meta'] = meta;
    return data;
  }
}

class AdsData {
  List<Ads>? ads;
  int? total;
  int? page;
  int? limit;
  int? totalPages;
  bool? hasNext;
  bool? hasPrevious;
  FiltersApplied? filtersApplied;

  AdsData({
    this.ads,
    this.total,
    this.page,
    this.limit,
    this.totalPages,
    this.hasNext,
    this.hasPrevious,
    this.filtersApplied,
  });

  AdsData.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = [];
      json['ads'].forEach((v) {
        ads!.add(Ads.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    limit = json['limit'];
    totalPages = json['total_pages'];
    hasNext = json['has_next'];
    hasPrevious = json['has_previous'];
    filtersApplied = json['filters_applied'] != null
        ? FiltersApplied.fromJson(json['filters_applied'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (ads != null) {
      data['ads'] = ads!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['page'] = page;
    data['limit'] = limit;
    data['total_pages'] = totalPages;
    data['has_next'] = hasNext;
    data['has_previous'] = hasPrevious;
    if (filtersApplied != null) {
      data['filters_applied'] = filtersApplied!.toJson();
    }
    return data;
  }
}

class Ads {
  String? id;
  String? title;
  String? slug;
  String? status;
  String? userId;
  String? description;
  String? categoryId;
  String? categoryName;
  double? price;
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
  String? thumbnailUrl;
  String? ownerName;
  String? ownerAvatar;

  Ads({
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

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    status = json['status'];
    userId = json['user_id'];
    description = json['description'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];

    price = json['price'] != null ? (json['price'] as num).toDouble() : 0.0;

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
    final Map<String, dynamic> data = {};
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

class FiltersApplied {
  dynamic categoryId;
  dynamic locationId;
  dynamic countryCode;

  FiltersApplied({
    this.categoryId,
    this.locationId,
    this.countryCode,
  });

  FiltersApplied.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    locationId = json['location_id'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId;
    data['location_id'] = locationId;
    data['country_code'] = countryCode;
    return data;
  }
}