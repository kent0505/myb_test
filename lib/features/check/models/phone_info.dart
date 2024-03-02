class PhoneOperator {
  final int phone;
  final int blocked;
  final String? operator;
  final String? region;

  PhoneOperator({
    required this.phone,
    required this.blocked,
    this.operator,
    this.region,
  });

  factory PhoneOperator.fromJson(Map<String, dynamic> json) {
    return PhoneOperator(
      phone: json['callfilter_info']['phone'],
      blocked: json['callfilter_info']['blocked'],
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
