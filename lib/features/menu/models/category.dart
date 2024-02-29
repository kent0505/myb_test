class Category {
  final int id;
  final String name;
  bool checked;

  Category({
    required this.id,
    required this.name,
    this.checked = false,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
