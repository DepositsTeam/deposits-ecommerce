import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class EditShopDetailController extends GetxController {
  var isLoading = false.obs;
  var autovalidate = false.obs;
  final formKey = GlobalKey<FormState>();
  final storeName = TextEditingController();
  final storeDescription = TextEditingController();
  final streetAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  String storeCategory = '';
  List<String> storeCategoryList = [];

  ShopDetailController shopDetailController = Get.find();

  @override
  void dispose() {
    super.dispose();
    storeName.dispose();
    streetAddressController.dispose();
    zipCodeController.dispose();
    country.dispose();
    state.dispose();
    city.dispose();
  }

  void fetchStoreCategory(BuildContext context) async {
        storeCategoryList.clear();
    try {
      isLoading(true);
      var request = {
        // 'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey()
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/categories',
          method: Method.POST,
          params: request);

      ProductCategoryResponse productCategoryResponse =
          ProductCategoryResponse.fromJson(response);
      if (productCategoryResponse.status == Strings.success) {
        storeCategoryList.addAll( productCategoryResponse.data!);
      } else {
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } catch (e) {
      return Utils.showSnackbar(
          context, Strings.error, e.toString().toTitleCase(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
  }

  void editShopDetails(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try{
      isLoading.value = true;
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
        'name': storeName.text.toString(),
        'description': storeDescription.text.toString(),
        'category': storeCategory,
        'street_address': streetAddressController.text.toString(),
        'zip': zipCodeController.text.toString(),
        'country': country.text.toString(),
        'state': state.text.toString(),
        'city': city.text.toString(),
      };
      var response = await DioClient().request(context: context,
          api: '/merchant/update', method: Method.POST, params: request);

      GetSingleMerchantResponse getSingleMerchantResponse =
          GetSingleMerchantResponse.fromJson(response);

      if (getSingleMerchantResponse.status == Strings.success) {
        Utils.navigationReplace(
            context,
            SuccessfulMgs(
              successTitle: Strings.storeUpdatedSuccessfully,
              successMessage: DateFormat.jm()
                  .format(DateTime.parse(DateTime.now().toString()).toLocal()),
            ));
        shopDetailController.fetchShopDetails(context);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
      }catch(e){
      return Utils.showSnackbar(
            context, Strings.error, e.toString(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
    }
  }

  bool validateInput() {
    if (streetAddressController.text.isEmpty) {
      return false;
    } else if (zipCodeController.text.isEmpty) {
      return false;
    } else if (country.text.isEmpty) {
      return false;
    } else if (state.text.isEmpty) {
      return false;
    } else if (city.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
