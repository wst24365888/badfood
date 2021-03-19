import 'package:get/get.dart';

class UserInfoController extends GetxController {
  String _name = "";
  String _email = "";
  String _photoURL = "";
  String bearerToken = "";
  String _createAt = "";
  final RxInt _reportCount = 0.obs;

  String get name => _name;
  String get email => _email;
  String get photoURL => _photoURL;
  String get createAt => _createAt;
  int get reportCount => _reportCount.value;

  set reportCount(int r) => _reportCount.value = r;

  void setUserInfo({
    String name,
    String email,
    String photoURL,
    String createAt,
  }) {
    _name = name ?? "";
    _email = email ?? "";
    _photoURL = photoURL ?? "";
    _createAt = createAt ?? "";
  }

  int getRegisteredDays() =>
      DateTime.now().difference(DateTime.parse(createAt)).inDays;
}
