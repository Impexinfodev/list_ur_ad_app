class CategoryModel {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String? iconUrl;
  final bool isActive;
  final int sortOrder;
  final Map<String, dynamic> metaData;
  final String? parentId;
  final int subcategoryCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.iconUrl,
    required this.isActive,
    required this.sortOrder,
    required this.metaData,
    required this.parentId,
    required this.subcategoryCount,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      iconUrl: json['icon_url'],
      isActive: json['is_active'] ?? false,
      sortOrder: json['sort_order'] ?? 0,
      metaData: json['meta_data'] ?? {},
      parentId: json['parent_id'],
      subcategoryCount: json['subcategory_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "slug": slug,
      "description": description,
      "icon_url": iconUrl,
      "is_active": isActive,
      "sort_order": sortOrder,
      "meta_data": metaData,
      "parent_id": parentId,
      "subcategory_count": subcategoryCount,
    };
  }
}