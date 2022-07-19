
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeMenuController>(() => HomeMenuController());
    Get.lazyPut<EcomPaymentsController>(() => EcomPaymentsController());
    Get.lazyPut<ProductsController>(() => ProductsController());
    // Get.lazyPut<ShopSettingsController>(() => ShopSettingsController());
  }
}