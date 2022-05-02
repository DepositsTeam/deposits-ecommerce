import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class EditShippingPolicyController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final shippingInfo = TextEditingController();
  final returnPolicyInfo = TextEditingController();
  ShippingPolicyController shippingPolicyController = Get.find();

  @override
  void dispose() {
    super.dispose();
    shippingInfo.dispose();
    returnPolicyInfo.dispose();
  }

  bool validateInput() {
    if (shippingInfo.text.isEmpty) {
      return false;
    } else if (returnPolicyInfo.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void editShippingInfo(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      try {
        var request = {
          'merchant_id': Storage.getValue(Constants.merchantID),
          'api_key': await Constants.apiKey(),
          'return_policy': returnPolicyInfo.text.toString(),
          'shipping_policy': shippingInfo.text.toString(),
        };
        var response = await DioClient().request(
            context: context,
            api: '/merchant/update-merchant-shipping-and-return-policy',
            method: Method.POST,
            params: request);
        GetSingleMerchantResponse getSingleMerchantResponse =
            GetSingleMerchantResponse.fromJson(response);

        if (getSingleMerchantResponse.status == Strings.success) {
          Utils.navigationReplace(
              context,
              SuccessfulMgs(
                successTitle: Strings.shippinPolicyUpdatedSuccessfully,
                successMessage: DateFormat.jm().format(
                    DateTime.parse(DateTime.now().toString()).toLocal()),
              ));
          shippingPolicyController.fetchShippingRetunPolicy(context);
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
  }
}
