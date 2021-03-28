import 'package:badfood/models/store_place.dart';

class DetailedReport {
  DetailedData data;

  DetailedReport({this.data});

  DetailedReport.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? DetailedData.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DetailedData {
  int id;
  String title;
  String symptom;
  String note;
  String happenedAt;
  StorePlace place;
  List<ReportImageInfo> image;

  DetailedData({
    this.id,
    this.title,
    this.symptom,
    this.note,
    this.happenedAt,
    this.place,
    this.image,
  });

  DetailedData.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    title = json['title'].toString();
    symptom = json['symptom'].toString();
    note = json['note']?.toString();
    happenedAt = json['happened_at'].toString();
    place = json['place'] != null
        ? StorePlace.fromJson(json['place'] as Map<String, dynamic>)
        : null;
    if (json['image'] != null) {
      image = <ReportImageInfo>[];
      json['image'].forEach((v) {
        image.add(ReportImageInfo.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['symptom'] = symptom;
    data['note'] = note;
    data['happened_at'] = happenedAt;
    if (place != null) {
      data['place'] = place.toJson();
    }
    if (image != null) {
      data['image'] = image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReportImageInfo {
  String id;

  ReportImageInfo({this.id});

  ReportImageInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
