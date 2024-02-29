import 'dart:convert';

class ValidateAds {
  String status;
  String reason;

  ValidateAds({
    required this.status,
    required this.reason,
  });

  factory ValidateAds.fromRawJson(String str) =>
      ValidateAds.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ValidateAds.fromJson(Map<String, dynamic> json) => ValidateAds(
        status: json["status"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "reason": reason,
      };
}
