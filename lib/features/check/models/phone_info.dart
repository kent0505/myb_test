class PhoneInfo {
  final String? operator;
  final String? region;

  PhoneInfo({
    this.operator,
    this.region,
  });

  factory PhoneInfo.fromJson(Map<String, dynamic> json) {
    return PhoneInfo(
      operator: json['operator_info']['operator'],
      region: json['operator_info']['region'],
    );
  }
}

// class PhoneInfo {
 
//   final List<int> categories;
 

//   PhoneInfo({
//     required this.phoneNumber,
//     this.operator,
//     this.region,
//     required this.categories,
//     required this.comment,
//     required this.warnOnly,
//   });

//   // Factory method to parse JSON into PhoneInfo model
//   factory PhoneInfo.fromJson(Map<String, dynamic> json) {
//     return PhoneInfo(
 
 
//       categories: List<int>.from(json['categories']),
 
//     );
//   }
// }
