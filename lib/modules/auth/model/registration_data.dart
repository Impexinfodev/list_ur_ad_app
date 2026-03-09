class RegistrationData {
  String? name;
  String? phone;
  String? countryCode;
  bool? isPrivacyAccepted;
  List<String>? selectedLanguages;
  List<String>? selectedLocations;

  Map<String, dynamic> toJson() {
    return {
      "name": name ?? "",
      "phone": phone ?? "",
      "country_code": countryCode ?? "",
      "privacy_accepted": isPrivacyAccepted ?? false,
      "readable_languages": selectedLanguages ?? [],
      "selected_locations": selectedLocations ?? [],
    };
  }
}