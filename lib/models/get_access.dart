import 'dart:convert';

class GetAccess {
  bool status;
  Message message;

  GetAccess({
    required this.status,
    required this.message,
  });

  factory GetAccess.fromRawJson(String str) =>
      GetAccess.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAccess.fromJson(Map<String, dynamic> json) => GetAccess(
        status: json["status"],
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message.toJson(),
      };
}

class Message {
  String user;
  String password;
  DateTime sessionStart;
  DateTime sesssionEnd;
  String sessionId;

  Message({
    required this.user,
    required this.password,
    required this.sessionStart,
    required this.sesssionEnd,
    required this.sessionId,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        user: json["user"],
        password: json["password"],
        sessionStart: DateTime.parse(json["session_start"]),
        sesssionEnd: DateTime.parse(json["sesssion_end"]),
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "password": password,
        "session_start": sessionStart.toIso8601String(),
        "sesssion_end": sesssionEnd.toIso8601String(),
        "session_id": sessionId,
      };
}
