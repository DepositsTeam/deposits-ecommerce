import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ProductDetailsController extends GetxController {
  void editProduct(BuildContext context, ProductData data) {
    Utils.navigationReplace(
        context,
        EditProduct(
          data:  data,
        ));
  }
}
