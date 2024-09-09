// import 'dart:async';
//
// class WidgetParameters {
//   final String parameter1;
//   final int parameter2;
//
//   WidgetParameters({
//     required this.parameter1,
//     required this.parameter2,
//   });
//
//   factory WidgetParameters.fromJson(Map<String, dynamic> json) {
//     return WidgetParameters(
//       parameter1: json['parameter1'] as String,
//       parameter2: json['parameter2'] as int,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'parameter1': parameter1,
//       'parameter2': parameter2,
//     };
//   }
// }
//
// class Asset {
//   final String id;
//   final String appShortCode;
//   final String assetModelShortCode;
//   final String widgetCode;
//   final String widgetType;
//   final String widgetSize;
//   final String widgetColorTheme;
//   final WidgetParameters widgetParameters;
//   final String purpose;
//
//   Asset({
//     required this.id,
//     required this.appShortCode,
//     required this.assetModelShortCode,
//     required this.widgetCode,
//     required this.widgetType,
//     required this.widgetSize,
//     required this.widgetColorTheme,
//     required this.widgetParameters,
//     required this.purpose,
//   });
//
//   factory Asset.fromJson(Map<String, dynamic> json) {
//     return Asset(
//       id: json['id'] as String,
//       appShortCode: json['app_short_code'] as String,
//       assetModelShortCode: json['asset_model_short_code'] as String,
//       widgetCode: json['widget_code'] as String,
//       widgetType: json['widget_type'] as String,
//       widgetSize: json['widget_size'] as String,
//       widgetColorTheme: json['widget_color_theme'] as String,
//       widgetParameters: WidgetParameters.fromJson(json['widget_parameters'] as Map<String, dynamic>),
//       purpose: json['purpose'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'app_short_code': appShortCode,
//       'asset_model_short_code': assetModelShortCode,
//       'widget_code': widgetCode,
//       'widget_type': widgetType,
//       'widget_size': widgetSize,
//       'widget_color_theme': widgetColorTheme,
//       'widget_parameters': widgetParameters.toJson(),
//       'purpose': purpose,
//     };
//   }
// }
//
// class LiveDataAsset {
//   final _assetStreamController = StreamController<Asset>.broadcast();
//   Asset _asset;
//
//   LiveDataAsset(this._asset);
//
//   Stream<Asset> get assetStream => _assetStreamController.stream;
//
//   void updateAsset(Asset newAsset) {
//     _asset = newAsset;
//     _assetStreamController.add(_asset);
//   }
//
//   void dispose() {
//     _assetStreamController.close();
//   }
// }


//============================================================================
//============================================================================



//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class TicketService {
//   static const String _baseUrl = 'http://localhost:3000/tickets';
//
//   Future<List<Ticket>> fetchTickets() async {
//     final response = await http.get(Uri.parse(_baseUrl));
//
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => Ticket.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load tickets');
//     }
//   }
// }
//
// class Ticket {
//   final String id;
//   final String title;
//   final String status;
//   final String createdBy;
//   final String createdOn;
//   final String category;
//   final String assignedOn;
//   final String assignedTo;
//
//   Ticket({
//     required this.id,
//     required this.title,
//     required this.status,
//     required this.createdBy,
//     required this.createdOn,
//     required this.category,
//     required this.assignedOn,
//     required this.assignedTo,
//   });
//
//   factory Ticket.fromJson(Map<String, dynamic> json) {
//     return Ticket(
//       id: json['id'],
//       title: json['title'],
//       status: json['status'],
//       createdBy: json['createdBy'],
//       createdOn: json['createdOn'],
//       category: json['category'],
//       assignedOn: json['assignedOn'],
//       assignedTo: json['assignedTo'],
//     );
//   }
// }



import 'dart:ffi';

class LiveData {
  final String app_short_code;
  final String asset_id;
  final String date;
  final Double ts;

  LiveData({
    required this.app_short_code,
    required this.asset_id,
    required this.date,
    required this.ts,
  });

  factory LiveData.fromJson(Map<String, dynamic> json) {
    return LiveData(
      app_short_code: json['app_short_code'] ?? "",
      asset_id: json['asset_id'] ?? "",
      date: json['date'] ?? "",
      ts: json['ts'] ?? 0.0,
    );
  }

// Map<String, dynamic> toJson() {
//   return {
//     'id': id,
//     'title': title,
//     'status': status,
//     'createdBy': createdBy,
//     'createdOn': createdOn,
//     'category': category,
//     'allottedOn': allottedOn,
//     'assignedTo': assignedTo,
//   };
//}
}
