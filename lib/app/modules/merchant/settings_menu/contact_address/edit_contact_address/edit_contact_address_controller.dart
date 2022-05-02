import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class EditContactAddressController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final contact = TextEditingController();
  final address = TextEditingController();
  ContactAddressController contactAddressController = Get.find();

  @override
  void dispose() {
    super.dispose();
    contact.dispose();
    address.dispose();
  }

  bool validateInput() {
    if (contact.text.isEmpty) {
      return false;
    } else if (address.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void editContactAddress(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try{
      isLoading.value = true;
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
        'contact_info': contact.text.toString(),
        'contact_address': address.text.toString(),
      };
      var response = await DioClient().request(
        context: context,
          api: '/merchant/update-merchant-contact-and-address',
          method: Method.POST,
          params: request);
      GetSingleMerchantResponse getSingleMerchantResponse =
          GetSingleMerchantResponse.fromJson(response);
      if (getSingleMerchantResponse.status == Strings.success) {
        Utils.navigationReplace(
            context,
            SuccessfulMgs(
              successTitle: Strings.addressUpdatedSuccessfully,
              successMessage: DateFormat.jm()
                  .format(DateTime.parse(DateTime.now().toString()).toLocal()),
            ));
        contactAddressController.fetchShopDetails(context);
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
