import 'package:deposits_ecommerce/deposits_ecommerce.dart';
import 'package:deposits_oneclick_checkout/app/modules/deposits_oneclick_checkout_button.dart'
    as CheckoutButton;

class ShopItemDetailController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final addressName = TextEditingController();
  final zipCodeController = TextEditingController();
  final streetAddressController = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  RxList<ShippingAddressData> addresses = <ShippingAddressData>[].obs;
  final DepositsEcommerceContext? shopContext;

  ShopItemDetailController({this.shopContext});

  @override
  void onInit() async {
    super.onInit();
    streetAddressController.text = '';
    zipCodeController.text = '';
    country.text = '';
    state.text = '';
    city.text = '';
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

  Future<void> fetchAddress(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
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

  void orderCheckOut(BuildContext context, double amount, String transactionId,
      ProductData data) async {
    var addresss =
        addresses.firstWhere((element) => element.isDefaultAddress == 'true');
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
        'amount': amount,
        'currency': "USD",
        'customer_id': Storage.getValue(Constants.customerID),
        'shipping_fee': data.shippingFee.toString(),
        'tax': data.tax.toString(),
        'transaction_id': transactionId,
        'zip': addresss.zip ?? '',
        'street_address': addresss.streetAddress ?? '',
        'address_name': addressName.text.toString(),
        'city': addresss.city ?? '',
        'state': addresss.state ?? '',
        'country': addresss.country ?? '',
        'save_address': "false",
        'is_default_address': "false",
        'product_ids': [data.id],
        'quantity_list': ["1"],
        'meta': {"address": addresss.streetAddress ?? ''}
      };
      var response = await DioClient().request(
          context: context,
          api: '/customer/orders/checkout',
          method: Method.FORM,
          payloadObj: request);

      OrderCheckoutResponse getAddressResponse =
          OrderCheckoutResponse.fromJson(response);
      if (getAddressResponse.status == Strings.success) {
        return Utils.showSnackbar(context, Strings.success,
            response['message'].toString().toTitleCase(), AppColors.green);
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

  void clickToShopItem(
    BuildContext context,
    double amount,
    ProductData data,
  ) async {
    // print('customer email is : ${Storage.getValue(Constants.customerEmail)}');
    // print('oneclick api key is : ${ Constants.oneClickApiKey()}');
    CheckoutButton.depositsCheckout(
        context, CheckoutButton.ButtonConfig(amount: amount),
        userEmail: Storage.getValue(Constants.customerEmail),
        apiKey: Constants.oneClickApiKey(),
        envMode: true, chargeFundsResponse: (response) {
      if (response.data != null) {
        orderCheckOut(context, amount, response.data!.transactionId!, data);
      }
      shopContext?.checkoutEvent.add(response);
    });
  }
}
