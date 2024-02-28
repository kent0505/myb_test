class PhoneInfo {
  final int phone;
  final int blocked;
  final String? operator;
  final String? region;

  PhoneInfo({
    required this.phone,
    required this.blocked,
    this.operator,
    this.region,
  });

  factory PhoneInfo.fromJson(Map<String, dynamic> json) {
    return PhoneInfo(
      phone: json['callfilter_info']['phone'],
      blocked: json['callfilter_info']['blocked'],
      operator: json['operator_info']['operator'],
      region: json['operator_info']['region'],
    );
  }
}
