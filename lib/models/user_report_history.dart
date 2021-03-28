import 'package:badfood/models/store_place.dart';

class UserReportHistory {
  List<StoreDataAndPlace> data;

  UserReportHistory({this.data});

  UserReportHistory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StoreDataAndPlace>[];
      json['data'].forEach((v) {
        data.add(StoreDataAndPlace.fromJson(v as Map<String, dynamic>));
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

class StoreDataAndPlace {
  int id;
  String title;
  String happenedAt;
  StorePlace place;

  StoreDataAndPlace({this.id, this.title, this.happenedAt, this.place});

  StoreDataAndPlace.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    title = json['title'].toString();
    happenedAt = json['happened_at'].toString();
    place = json['place'] != null
        ? StorePlace.fromJson(json['place'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['happened_at'] = happenedAt;
    if (place != null) {
      data['place'] = place.toJson();
    }
    return data;
  }
}
