import 'dart:convert';

class GetAds {
  String hash;
  String url;
  String from;
  String sample;
  String keyword;

  GetAds({
    required this.hash,
    required this.url,
    required this.from,
    required this.sample,
    required this.keyword,
  });

  factory GetAds.fromRawJson(String str) => GetAds.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAds.fromJson(Map<String, dynamic> json) => GetAds(
        hash: json["hash"],
        url: json["url"],
        from: json["from"],
        sample: json["sample"],
        keyword: json["keyword"],
      );

  Map<String, dynamic> toJson() => {
        "hash": hash,
        "url": url,
        "from": from,
        "sample": sample,
        "keyword": keyword,
      };
}
