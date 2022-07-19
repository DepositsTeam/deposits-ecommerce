import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class DeleteAccountController extends GetxController {
  var isDeleteShop = false.obs;
  var isLoading = false.obs;
  final DepositsEcommerceContext shopContext;

  DeleteAccountController({
    required this.shopContext,
  });

  void toggleDefaultAddress(bool value) {
    isDeleteShop.value = value;
    update();
  }

  void deletShop(BuildContext context) async {
    
    if (isDeleteShop.isFalse) {
      return Utils.showSnackbar(context, Strings.error,
          'Please check to aggree to deleting your account', AppColors.red);
    } else {
      try{
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
      };
      var response = await DioClient().request(
        context: context,
          api: '/merchant/delete-merchant',
          method: Method.POST,
          params: request);
      DeleteResponse deleteMerchantResponse =
          DeleteResponse.fromJson(response);
      if (deleteMerchantResponse.status == Strings.success) {
        print('shopCOntext hasCode ${shopContext.hashCode}');
         shopContext.deleteShopEvent.add(deleteMerchantResponse);
        Utils.navigationReplace(
            context,
            SuccessfulMgs(
              successTitle: Strings.delAc,
              successMessage: Strings.delAcMgs,
            ));
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
      }catch(e){
      return Utils.showSnackbar(
            context, Strings.error, e.toString().toTitleCase(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
    }
  }
}
