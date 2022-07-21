
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class DashboardController extends GetxController{
    var tabIndex = 0.obs;
   bool isSelected = true;
   //---------------------------------------------------------------
 

  void changeTabIndex(int index) {
    tabIndex.value = index;
    update();
  }
}