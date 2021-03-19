import 'package:badfood/models/store_location.dart';

class ReportedStores {
  List<StoreData> data;

  ReportedStores({this.data});

  ReportedStores.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StoreData>[];
      json['data'].forEach((v) {
        data.add(StoreData.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StoreData {
  String placeId;
  String name;
  StoreLocation location;
  List<StoreReport> reports;
  int reportsCount;

  StoreData({
    this.placeId,
    this.name,
    this.location,
    this.reports,
    this.reportsCount,
  });

  StoreData.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'].toString();
    name = json['name'].toString();
    location = json['location'] != null
        ? StoreLocation.fromJson(json['location'] as Map<String, dynamic>)
        : null;
    if (json['reports'] != null) {
      reports = <StoreReport>[];
      json['reports'].forEach((v) {
        reports.add(StoreReport.fromJson(v as Map<String, dynamic>));
      });
    }
    reportsCount = int.parse(json['reports_count'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;
    data['name'] = name;
    if (location != null) {
      data['location'] = location.toJson();
    }
    if (reports != null) {
      data['reports'] = reports.map((v) => v.toJson()).toList();
    }
    data['reports_count'] = reportsCount;
    return data;
  }
}

class StoreReport {
  int id;
  String title;
  String happenedAt;

  StoreReport({this.id, this.title, this.happenedAt});

  StoreReport.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    title = json['title'].toString();
    happenedAt = json['happened_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['happened_at'] = happenedAt;
    return data;
  }
}
