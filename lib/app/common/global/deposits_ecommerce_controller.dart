import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:deposits_ecommerce/app/model/customer_model/get_customer/get_customer_response.dart';

class DepositEcommerceController extends GetxController {
  RxList<ProductData> items = <ProductData>[].obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;

  void fetchProducts(BuildContext context, String? consumerApiKey,
      String? merchantId, String? customerId) async {
    items.clear();
    try {
      isLoading(true);
      var request = {
        'api_key': await Constants.apiKey(),
        'merchant_id': merchantId ?? Storage.getValue(Constants.merchantID),
        'customer_id': customerId ?? Storage.getValue(Constants.customerID)
      };
      var response = await DioClient().request(
          context: context,
          api: '/customer/products/featured',
          method: Method.POST,
          params: request);
      if (response != null) {
        GetProductsResponse getProductsResponse =
            GetProductsResponse.fromJson(response);
        if (getProductsResponse.status == Strings.success) {
          items.addAll(getProductsResponse.data!.obs);
        } else {
          isError(true);
          errorMessage.value = response['message'].toString().toTitleCase();
          return Utils.showSnackbar(context, Strings.error,
              response['message'].toString().toTitleCase(), AppColors.red);
        }
      }else{
        isError(true);
        errorMessage.value = 'Connection timeout with API server';
      }
    } finally {
      isLoading(false);
      isError(false);
    }
    update();
  }

  void getCustumerDetails(
      BuildContext context, String? merchantId, String? customerId) async {
    try {
      // isLoading(true);
      var customerId = merchantId ?? Storage.getValue(Constants.merchantID);
      var request = {
        'api_key': await Constants.apiKey(),
        'merchant_id': customerId.toString(),
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/customers/$customerId',
          method: Method.POST,
          params: request);
      if (response != null) {
        GetCustomerResponse getCustomerResponse =
            GetCustomerResponse.fromJson(response);
        if (getCustomerResponse.status == Strings.success) {
          Storage.removeValue(Constants.customerEmail);
          Storage.saveValue(
              Constants.customerEmail, getCustomerResponse.data!.email);
        } else {
          isError(true);
          errorMessage.value = response['message'].toString().toTitleCase();
          return Utils.showSnackbar(context, Strings.error,
              response['message'].toString().toTitleCase(), AppColors.red);
        }
      }else{
        isError(true);
        errorMessage.value = 'Connection timeout with API server';
      }
    } finally {
      // isLoading(false);
      // isError(false);
    }
    update();
  }
}
