class ApiUrl {
  // static const String baseUrl = "https://api.listurad.aashita.ai";
  static const String baseUrl = "http://192.168.1.16:8000";

  static const register = "$baseUrl/api/v1/auth/register";
  static const login = "$baseUrl/api/v1/auth/login";
  static const sendOtp = "$baseUrl/api/v1/auth/otp/send";
  static const reSendOtp = "$baseUrl/api/v1/auth/otp/resend";
  static const verifyOtp = "$baseUrl/api/v1/auth/otp/verify";
  static const checkPhone = "$baseUrl/api/v1/auth/check-phone";
  static const languages = "$baseUrl/api/v1/data/languages";
  static const locations = "$baseUrl/api/v1/data/locations";
  static const categories = "$baseUrl/api/v1/categories";

  static String subCategories(String categoryId) =>
      "$baseUrl/api/v1/categories/$categoryId/subcategories";

  static const ads = "$baseUrl/api/v1/ads";
  static const likes = "$baseUrl/api/v1/likes";
  static String likeAd(String adId) => "$baseUrl/api/v1/ads/$adId/like";

  static String bookmarkAd(String adId) => "$baseUrl/api/v1/ads/$adId/bookmark";
  static String share(String adId) => "$baseUrl/api/v1/ads/$adId/share";



}
