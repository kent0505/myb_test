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
