import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class DeliveryAddressController extends GetxController {
  var isLoading = false.obs;
  var sdkKey = ''.obs;
  RxList<ShippingAddressData> addresses = <ShippingAddressData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    sdkKey = Constants.orderApiKey().obs;
  }

  //----------------------------------------------
  void fetchAddress(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': /*await Constants.apiKey(),*/ sdkKey.value,
        'customer_id': Storage.getValue(Constants.customerID)
      };
      var response = await DioClient().request(
          context: context,
          api: '/customer/shipping/get',
          method: Method.POST,
          params: request);
      AllShippingAddressResponse getAddressResponse =
          AllShippingAddressResponse.fromJson(response);
      if (getAddressResponse.status == Strings.success) {
        addresses = getAddressResponse.data!.obs;
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

  void editMailingAddress(
      BuildContext context, ShippingAddressData userAddress) {
    Utils.navigationPush(
        context,
        EditAddress(
          address: userAddress,
        ));
  }

  void addDeliveryAddress(
    BuildContext context,
  ) {
    Utils.navigationPush(context, AddDeliveryAddress());
  }
}
