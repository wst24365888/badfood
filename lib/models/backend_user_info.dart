class BackendUserInfo {
  int id;
  String firebaseUid;
  String name;
  String email;
  String createdAt;
  String updatedAt;
  String deletedAt;

  BackendUserInfo({
    this.id,
    this.firebaseUid,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  BackendUserInfo.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    firebaseUid = json['firebase_uid'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    deletedAt = json['deleted_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firebase_uid'] = firebaseUid;
    data['name'] = name;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
