class Phone {
  final String phone;
  final List categories;
  final String? comment;
  final bool warn;

  Phone({
    required this.phone,
    required this.categories,
    this.comment,
    required this.warn,
  });

  factory Phone.fromJson(Map<String, dynamic> json) {
    return Phone(
      phone: json['phone_number'],
      categories: json['categories'],
      comment: json['comment'],
      warn: json['warn_only'],
    );
  }
}
