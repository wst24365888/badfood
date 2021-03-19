import 'package:get/get.dart';

class NavigatorController extends GetxController {
  final RxInt _currentPage = 3.obs;

  int get currentPage => _currentPage.value;
  set currentPage(int c) => _currentPage.value = c;
}
