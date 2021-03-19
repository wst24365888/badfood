class StoreLocation {
  double lat;
  double lng;

  StoreLocation({this.lat, this.lng});

  StoreLocation.fromJson(Map<String, dynamic> json) {
    lat = double.parse(json['lat'].toString());
    lng = double.parse(json['lng'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
