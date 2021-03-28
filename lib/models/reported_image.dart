class ReportedImage {
  String status;
  String url;

  ReportedImage({this.status, this.url});

  ReportedImage.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    url = json['url'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['url'] = url;
    return data;
  }
}
