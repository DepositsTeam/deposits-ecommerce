import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class EditAddressController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  var autovalidate = false.obs;
  var isDefaultAddressSet = false.obs;
  var isSaveForLater = false.obs;
  final addressName = TextEditingController();
  final streetAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final country=TextEditingController();
  final state=TextEditingController();
  final city=TextEditingController();
  DeliveryAddressController deliveryAddressController = Get.find();
  ShopItemDetailController shopItemDetailController = Get.find();

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

  void toggleDefaultAddress(bool value) {
    isDefaultAddressSet.value = value;
    update();
  }

void toggleIsSaveForLaters(bool value) {
    isSaveForLater.value = value;
    update();
  }

  void editAddress(BuildContext context,String addressId)async{
     FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
        'customer_id': Storage.getValue(Constants.customerID),
        'zip':zipCodeController.text.toString(),
        'address_name':addressName.text.toString(),
        'street_address':streetAddressController.text.toString(),
        'city':city.text.toString(),
        'state':state.text.toString(),
        'country':country.text.toString(),
        'is_default_address': "false",
      };

      var response = await DioClient().request(
        context: context,
          api: '/customer/shipping/update/$addressId', method: Method.POST, params: request);
      ShippingAddressResponse getAddressResponse = ShippingAddressResponse.fromJson(response);
      if (getAddressResponse.status == Strings.success) {
        if (isDefaultAddressSet.isTrue) {
          makeAddressDefault(context,addressId);
        }else{
          isLoading(false);
       Utils.navigationReplace(context, SuccessfulMgs(
                  successTitle: Strings.addressUpdated,
                  successMessage:Strings.addressUpdatedSuccessfully,));
       deliveryAddressController.fetchAddress(context);
       shopItemDetailController.fetchAddress(context);
      }
      } else {
        isLoading(false);
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
      }catch(e){
        isLoading(false);
      return Utils.showSnackbar(
            context, Strings.error, e.toString(), AppColors.red);
    } 

    }
  }

  void makeAddressDefault(BuildContext context,String addressId)async{
      try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
        'customer_id': Storage.getValue(Constants.customerID),
      };

      var response = await DioClient().request(
        context: context,
          api: '/customer/shipping/make-shipping-address-default/$addressId', method: Method.POST, params: request);
      ShippingAddressResponse getAddressResponse = ShippingAddressResponse.fromJson(response);
      if (getAddressResponse.status == Strings.success) {
       Utils.navigationReplace(context, SuccessfulMgs(
                  successTitle: Strings.addressUpdated,
                  successMessage:Strings.addressUpdatedSuccessfully,));
       deliveryAddressController.fetchAddress(context);
       shopItemDetailController.fetchAddress(context);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
      }catch(e){
      return Utils.showSnackbar(
            context, Strings.error, e.toString(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
  }


    void deleteAddress(BuildContext context,String addressId)async{
     FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      try{
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
        'customer_id': Storage.getValue(Constants.customerID),
      };
      var response = await DioClient().request(
        context: context,
          api: '/customer/shipping/delete/$addressId',
          method: Method.POST,
          params: request);
          DeleteResponse deleteMerchantResponse =
          DeleteResponse.fromJson(response);
      if (deleteMerchantResponse.status == Strings.success) {
        Utils.navigationReplace(context, SuccessfulMgs(
                  successTitle: Strings.addressDeleted,
                  successMessage:Strings.addressDeletedSuccessfully,));
         deliveryAddressController.fetchAddress(context);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
      }catch(e){
      return Utils.showSnackbar(
            context, Strings.error, e.toString(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
    }
  }

     bool validateInput( ) {
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

}