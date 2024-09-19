class Asset {
  final String id;
  final String appShortCode;
  final String displayName;
 // final String status;
  final DateTime lastUpdated; // Example field for status inference
  final int health; // Example field to determine if the asset is healthy

  Asset({
    required this.id,
    required this.appShortCode,
    required this.displayName,
   // this.status = 'unknown',
    required this.lastUpdated,
    required this.health,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'] as String,
      appShortCode: json['app_short_code'],
      displayName: json['display_name'],
     // status: json['status'] ?? 'unknown',
      lastUpdated: DateTime.parse(json['last_updated']),
      health: json['health'] ?? 100, // Default to 100 if not present
    );
  }

  String get status {
    // Example logic to infer status based on lastUpdated and health
    if (DateTime.now().difference(lastUpdated).inHours > 24) {
      return 'disconnected';
    } else if (health < 50) {
      return 'off';
    } else {
      return 'connected';
    }
  }
}
