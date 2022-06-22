import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class AddDeliveryAddressController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  var autovalidate = false.obs;
  var isReady = false.obs;
  final addressName = TextEditingController();
  final streetAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  DeliveryAddressController deliveryAddressController = Get.find();

  @override
  void onInit() {
    super.onInit();
    addressName.text = '';
    streetAddressController.text = '';
    zipCodeController.text = '';
    country.text = '';
    state.text = '';
    city.text = '';
    addressName.addListener(() {
      update();
    });
    streetAddressController.addListener(() {
      update();
    });
    zipCodeController.addListener(() {
      update();
    });
    country.addListener(() {
      update();
    });
    state.addListener(() {
      update();
    });
    city.addListener(() {
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
    addressName.dispose();
    streetAddressController.dispose();
    zipCodeController.dispose();
    country.dispose();
    state.dispose();
    city.dispose();
  }

  void addDeliveryAddress(
    BuildContext context,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'merchant_id': Storage.getValue(Constants.merchantID),
          'api_key': await Constants.apiKey(),
          'customer_id': Storage.getValue(Constants.customerID),
          "zip": zipCodeController.text.toString(),
          "address_name": addressName.text.toString(),
          "street_address": streetAddressController.text.toString(),
          "city": city.text.toString(),
          "state": state.text.toString(),
          "country": country.text.toString(),
          "is_default_address": "false",
        };
        print("add address body : $request");
        var response = await DioClient().request(
            context: context,
            api: '/customer/shipping/create',
            method: Method.POST,
            params: request);
        print("");
        ShippingAddressResponse getAddressResponse =
            ShippingAddressResponse.fromJson(response);
        if (getAddressResponse.status == Strings.success) {
          Utils.navigationReplace(
              context,
              SuccessfulMgs(
                successTitle: Strings.addressAddedSuccessfully,
                successMessage: DateFormat.jm().format(
                    DateTime.parse(DateTime.now().toString()).toLocal()),
              ));
          deliveryAddressController.fetchAddress(context);
        } else {
          return Utils.showSnackbar(context, Strings.error,
              response['message'].toString().toTitleCase(), AppColors.red);
        }
      } catch (e) {
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

  // if (formKey.currentState.validate()) {
  //   //form is valid, proceed further
  //   formKey.currentState!.save();//save once fields are valid, onSaved method invoked for every form fields

  // } else {
  //     _autovalidate = true; //enable realtime validation
  // }

}
