import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ShippingPolicyController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  Rx<MerchantData> merchantShipReturnData = MerchantData().obs;

  void editShippingPolicy(BuildContext context) {
    Utils.navigationPush(
        context,
        EditShippingPolicy(
         
          merchantShipReturnData: merchantShipReturnData.value,
        ));
  }

  void fetchShippingRetunPolicy(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey()
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/get-info',
          method: Method.POST,
          params: request);

      GetSingleMerchantResponse merchantResponse =
          GetSingleMerchantResponse.fromJson(response);
      if (merchantResponse.status == Strings.success) {
        merchantShipReturnData = merchantResponse.data!.obs;
      } else {
         isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
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
