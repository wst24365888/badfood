import 'package:badfood/models/store_location.dart';

class StorePlace {
  String placeId;
  String name;
  StoreLocation location;

  StorePlace({this.placeId, this.name, this.location});

  StorePlace.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'].toString();
    name = json['name'].toString();
    location = json['location'] != null
        ? StoreLocation.fromJson(json['location'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place_id'] = placeId;
    data['name'] = name;
    if (location != null) {
      data['location'] = location.toJson();
    }
    return data;
  }
}
