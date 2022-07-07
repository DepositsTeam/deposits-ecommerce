import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ShopDetailController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  Rx<MerchantData> merchantData = MerchantData().obs;

  void editShopDetail(BuildContext context) {
    Utils.navigationPush(
        context,
        EditShopDetail(
          merchantData: merchantData.value,
        ));
  }

  Future<void> refreshShopDetails(BuildContext context) async {
    fetchShopDetails(context);
  }

  void fetchShopDetails(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey()
      };
      print(request);
      var response = await DioClient().request(
          context: context,
          api: '/merchant',
          method: Method.POST,
          params: request);

      GetSingleMerchantResponse getSingleMerchantResponse =
          GetSingleMerchantResponse.fromJson(response);
      if (getSingleMerchantResponse.status == Strings.success) {
        merchantData = getSingleMerchantResponse.data!.obs;
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        return Utils.showSnackbar(
            context,
            Strings.error,
            response['message']
                .toString()
                .toTitleCase()
                .toString()
                .toTitleCase(),
            AppColors.red);
      }
    } catch (e) {
      isError(true);
      errorMessage.value = e.toString().toTitleCase();
      return Utils.showSnackbar(
          context, Strings.error, e.toString().toTitleCase(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
  }
}
