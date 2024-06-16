import 'package:get/get.dart';
enum Filters{all,lowToHigh,highToLow}
class AvailableServicesController extends GetxController{
  Rx<Filters> filter=Filters.all.obs;
  RxString search=''.obs;
  changeFilter({required Filters f}){
    filter.value=f;
    Get.back();
  }
}