import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class TaxFeeController extends GetxController {
 var isLoading = false.obs;
 var isError = false.obs;
  var errorMessage = ''.obs;
  Rx<MerchantData> merchantData = MerchantData().obs;


    void fetchShopDetails(BuildContext context ) async {
      try{
    isLoading(true);
    var request = {
      'merchant_id': Storage.getValue(Constants.merchantID),
      'api_key': await Constants.apiKey()
    };
    var response = await DioClient()
        .request(
          context: context,
          api: '/merchant', method: Method.POST, params: request);

    GetSingleMerchantResponse getSingleMerchantResponse =
        GetSingleMerchantResponse.fromJson(response);
    if (getSingleMerchantResponse.status == Strings.success) {
      if (getSingleMerchantResponse.data !=null) {
        // Utils.navigationPush(
        //       context,
        //       AddTaxFee(
        //       ));
        merchantData = getSingleMerchantResponse.data!.obs;
      } else {
        //add tax fee
          Utils.navigationPush(
              context,
              AddTaxFee());
      }
      
    } else {
      isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
      return Utils.showSnackbar(
          context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
    }
    }catch(e){
      isError(true);
        errorMessage.value = e.toString().toTitleCase();
      return Utils.showSnackbar(
            context, Strings.error, e.toString(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
  }

  void editTaxFee(BuildContext context){
    Utils.navigationPush(
      context, 
      EditTaxFee(merchantData: merchantData.value,));
  }
}