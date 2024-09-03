


class App {
  final String id;
  final String displayName;
  final String shortCode;
  final String description;
  final String iconUri;

  App({
    required this.id,
    required this.displayName,
    required this.shortCode,
    required this.description,
    required this.iconUri,
  });

  factory App.fromJson(Map<String, dynamic> json) {
    return App(
      id: json['id'],
      displayName: json['display_name']?? 'Unknown',
      shortCode: json['short_code'],
      description: json['description'],
      iconUri: json['icon_uri']?? 'assets/images/iot.png',
    );
  }
}