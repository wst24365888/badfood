import 'package:get/get.dart';

class MainScreenController extends GetxController {
  final RxInt _currentPage = 3.obs;
  final RxBool _isLoading = false.obs;

  int get currentPage => _currentPage.value;
  set currentPage(int c) => _currentPage.value = c;

  bool get isLoading => _isLoading.value;
  set isLoading(bool i) => _isLoading.value = i;
}
