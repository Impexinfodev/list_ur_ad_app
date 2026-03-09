class SubCategoryModel {
  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? iconUrl;
  final int sortOrder;

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.iconUrl,
    required this.sortOrder,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'],
      iconUrl: json['icon_url'],
      sortOrder: json['sort_order'] ?? 0,
    );
  }
}