class ProfileModel {
  bool? success;
  String? message;
  ProfileData? data;
  dynamic errorCode;
  dynamic errors;
  dynamic meta;

  ProfileModel({this.success, this.message, this.data, this.errorCode, this.errors, this.meta});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
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

class ProfileData {
  String? id;
  String? phone;
  dynamic email;
  String? fullName;
  String? username;
  dynamic avatarUrl;
  dynamic coverUrl;
  dynamic bio;
  dynamic gender;
  dynamic dateOfBirth;
  dynamic profession;
  dynamic website;
  String? appLanguage;
  List<String>? readableLanguages;
  String? country;
  String? timezone;
  dynamic city;
  dynamic state;
  dynamic locationLat;
  dynamic locationLng;
  int? rangeKm;
  List<dynamic>? selectedLocations;
  List<dynamic>? interests;
  int? followersCount;
  int? followingCount;
  int? adsCount;
  int? liveAdsCount;
  bool? isPhoneVerified;
  bool? isEmailVerified;
  bool? isActive;
  bool? isProfilePublic;
  bool? isBanned;
  dynamic banReason;
  dynamic bannedAt;
  String? role;
  bool? showPhoneInAds;
  bool? twoFactorEnabled;
  bool? pushNotifications;
  bool? emailNotifications;
  bool? smsNotifications;
  bool? acceptedTerms;
  dynamic acceptedTermsAt;
  bool? acceptedPrivacy;
  dynamic acceptedPrivacyAt;
  String? dialCode;
  dynamic countryCode;
  bool? onboardingCompleted;
  int? onboardingStep;
  String? createdAt;
  String? updatedAt;
  String? lastActiveAt;

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    fullName = json['full_name'];
    username = json['username'];
    avatarUrl = json['avatar_url'];
    coverUrl = json['cover_url'];
    bio = json['bio'];
    gender = json['gender'];
    dateOfBirth = json['date_of_birth'];
    profession = json['profession'];
    website = json['website'];
    appLanguage = json['app_language'];

    readableLanguages =
        (json['readable_languages'] as List?)?.map((e) => e.toString()).toList() ?? [];

    country = json['country'];
    timezone = json['timezone'];
    city = json['city'];
    state = json['state'];
    locationLat = json['location_lat'];
    locationLng = json['location_lng'];
    rangeKm = json['range_km'];

    selectedLocations = json['selected_locations'] ?? [];
    interests = json['interests'] ?? [];

    followersCount = json['followers_count'];
    followingCount = json['following_count'];
    adsCount = json['ads_count'];
    liveAdsCount = json['live_ads_count'];

    isPhoneVerified = json['is_phone_verified'];
    isEmailVerified = json['is_email_verified'];
    isActive = json['is_active'];
    isProfilePublic = json['is_profile_public'];
    isBanned = json['is_banned'];

    banReason = json['ban_reason'];
    bannedAt = json['banned_at'];

    role = json['role'];

    showPhoneInAds = json['show_phone_in_ads'];
    twoFactorEnabled = json['two_factor_enabled'];
    pushNotifications = json['push_notifications'];
    emailNotifications = json['email_notifications'];
    smsNotifications = json['sms_notifications'];

    acceptedTerms = json['accepted_terms'];
    acceptedTermsAt = json['accepted_terms_at'];

    acceptedPrivacy = json['accepted_privacy'];
    acceptedPrivacyAt = json['accepted_privacy_at'];

    dialCode = json['dial_code'];
    countryCode = json['country_code'];

    onboardingCompleted = json['onboarding_completed'];
    onboardingStep = json['onboarding_step'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lastActiveAt = json['last_active_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['id'] = id;
    data['phone'] = phone;
    data['email'] = email;
    data['full_name'] = fullName;
    data['username'] = username;
    data['avatar_url'] = avatarUrl;
    data['cover_url'] = coverUrl;
    data['bio'] = bio;
    data['gender'] = gender;
    data['date_of_birth'] = dateOfBirth;
    data['profession'] = profession;
    data['website'] = website;
    data['app_language'] = appLanguage;
    data['readable_languages'] = readableLanguages;
    data['country'] = country;
    data['timezone'] = timezone;
    data['city'] = city;
    data['state'] = state;
    data['location_lat'] = locationLat;
    data['location_lng'] = locationLng;
    data['range_km'] = rangeKm;
    data['selected_locations'] = selectedLocations;
    data['interests'] = interests;
    data['followers_count'] = followersCount;
    data['following_count'] = followingCount;
    data['ads_count'] = adsCount;
    data['live_ads_count'] = liveAdsCount;
    data['is_phone_verified'] = isPhoneVerified;
    data['is_email_verified'] = isEmailVerified;
    data['is_active'] = isActive;
    data['is_profile_public'] = isProfilePublic;
    data['is_banned'] = isBanned;
    data['ban_reason'] = banReason;
    data['banned_at'] = bannedAt;
    data['role'] = role;
    data['show_phone_in_ads'] = showPhoneInAds;
    data['two_factor_enabled'] = twoFactorEnabled;
    data['push_notifications'] = pushNotifications;
    data['email_notifications'] = emailNotifications;
    data['sms_notifications'] = smsNotifications;
    data['accepted_terms'] = acceptedTerms;
    data['accepted_terms_at'] = acceptedTermsAt;
    data['accepted_privacy'] = acceptedPrivacy;
    data['accepted_privacy_at'] = acceptedPrivacyAt;
    data['dial_code'] = dialCode;
    data['country_code'] = countryCode;
    data['onboarding_completed'] = onboardingCompleted;
    data['onboarding_step'] = onboardingStep;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['last_active_at'] = lastActiveAt;

    return data;
  }
}
