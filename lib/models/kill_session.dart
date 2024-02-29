import 'dart:convert';

class KillSession {
  bool status;
  String message;

  KillSession({
    required this.status,
    required this.message,
  });

  factory KillSession.fromRawJson(String str) =>
      KillSession.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KillSession.fromJson(Map<String, dynamic> json) => KillSession(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
