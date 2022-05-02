import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class EditTaxFeeController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final taxId = TextEditingController();
  final taxPercentage = TextEditingController();
  final extraFee = TextEditingController();
  TaxFeeController taxFeeController = Get.find();

  @override
  void dispose() {
    super.dispose();
    taxId.dispose();
    taxPercentage.dispose();
    extraFee.dispose();
  }

  bool validateInput() {
    if (taxId.text.isEmpty) {
      return false;
    } else if (taxPercentage.text.isEmpty) {
      return false;
    } else if (extraFee.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void editTaxFee(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try{
      isLoading.value = true;
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
        'tax_id': taxId.text.toString(),
        'tax_percent': taxPercentage.text.toString(),
        'shipping_fee': extraFee.text.toString(),
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/update-merchant-tax-and-fee',
          method: Method.POST,
          params: request);
      GetSingleMerchantResponse getSingleMerchantResponse =
          GetSingleMerchantResponse.fromJson(response);
      if (getSingleMerchantResponse.status == Strings.success) {
        Utils.navigationReplace(
            context,
            SuccessfulMgs(
              successTitle: Strings.taxUpdatedSuccessfully,
              successMessage: DateFormat.jm()
                  .format(DateTime.parse(DateTime.now().toString()).toLocal()),
             
            ));
        taxFeeController.fetchShopDetails(context);
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
