import 'dart:convert';

class VpnFree {
  bool status;
  final List<Datum> data;

  VpnFree({
    required this.status,
    required this.data,
  });

  // factory VpnFree.fromRawJson(String str) => VpnFree.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory VpnFree.fromJson(Map<String, dynamic> json) => VpnFree(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "status": status,
  //       "data": List<dynamic>.from(data.map((x) => x.toJson())),
  //     };
}

class Datum {
  final String? serverId;
  final String? hostname;
  final String? region;
  final double? srvload;

  Datum({
    this.serverId,
    this.hostname,
    this.region,
    this.srvload,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serverId: json["server_id"] ?? "",
        hostname: json["hostname"] ?? "",
        region: json["region"] ?? "",
        srvload: double.parse((json['srvload'] ?? 0).toString()),
      );

  Map<String, dynamic> toJson() => {
        "server_id": serverId,
        "hostname": hostname,
        "region": region,
        "srvload": srvload
      };
}
