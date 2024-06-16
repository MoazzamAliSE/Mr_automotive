import 'package:get/get.dart';

import 'available_services_controller.dart';

class AvailableProductController extends GetxController{
  Rx<Filters> filter=Filters.all.obs;
  RxString search=''.obs;
  changeFilter({required Filters f}){
    filter.value=f;
    Get.back();
  }
}