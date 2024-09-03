class Asset {
  final String id;
  final String appShortCode;
  final String displayName;

  Asset({
    required this.id,
    required this.appShortCode,
    required this.displayName,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'],
      appShortCode: json['app_short_code'],
      displayName: json['display_name'],
    );
  }
}
