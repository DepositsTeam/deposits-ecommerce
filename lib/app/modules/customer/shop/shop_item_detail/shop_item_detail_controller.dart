import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import '../../../../services/logging.dart';
import 'package:deposits_ecommerce/deposits_ecommerce.dart';
import 'package:deposits_oneclick_checkout/app/modules/deposits_oneclick_checkout_button.dart'
    as CheckoutButton;

class ShopItemDetailController extends GetxController {
  var isLoading = false.obs;
  var isSaveForLater = false.obs;
  final formKey = GlobalKey<FormState>();
  final addressName = TextEditingController();
  final zipCodeController = TextEditingController();
  final streetAddressController = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  RxList<ShippingAddressData> addresses = <ShippingAddressData>[].obs;
  final DepositsEcommerceContext? shopContext;
  var oneClick = ''.obs;
  var sdkKey = ''.obs;
  var sdkbase = ''.obs;
  ShopItemDetailController({this.shopContext});

  @override
  void onInit() async {
    super.onInit();
    oneClick = Constants.oneClickApiKey().obs;
    sdkKey = Constants.orderApiKey().obs;
    sdkbase = Constants.orderBaseUrl().obs;
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

  void toggleIsSaveForLaters(bool value) {
    isSaveForLater.value = value;
    update();
  }

  Future<void> fetchAddress(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': sdkKey.value,
        'customer_id': Storage.getValue(Constants.customerID)
      };
      Dio dioService = Dio();
      dioService = Dio(BaseOptions(
        baseUrl: sdkbase.value,
      ))
        ..interceptors.add(Logging());
      (dioService.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      // print("fetch address request body : $request and url is: ${sdkbase.value}");
      var response =
          await dioService.post('/customer/shipping/get', data: request);
      // print("fetched address response : ${response.toString()}");
      if (response.statusCode == 200) {
        AllShippingAddressResponse getAddressResponse =
            AllShippingAddressResponse.fromJson(response.data);
        if (getAddressResponse.status == Strings.success) {
          addresses = getAddressResponse.data!.obs;
        } else {
          return Utils.showSnackbar(
              context,
              Strings.error,
              getAddressResponse.message.toString().toTitleCase(),
              AppColors.red);
        }
      } else {
        return Utils.showSnackbar(context, Strings.error,
            response.data['message'].toString().toTitleCase(), AppColors.red);
      }
    } catch (e) {
      return Utils.showSnackbar(
          context, Strings.error, e.toString().toTitleCase(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
  }

  void addDeliveryAddress(
    BuildContext context,
    double amount,
    ProductData data,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'merchant_id': Storage.getValue(Constants.merchantID),
          'api_key': sdkKey.value,
          'customer_id': Storage.getValue(Constants.customerID),
          "zip": zipCodeController.text.toString(),
          "address_name": addressName.text.toString(),
          "street_address": streetAddressController.text.toString(),
          "city": city.text.toString(),
          "state": state.text.toString(),
          "country": country.text.toString(),
          "is_default_address": "true",
        };
        Dio dioService = Dio();
        dioService = Dio(BaseOptions(
          baseUrl: sdkbase.value,
        ))
          ..interceptors.add(Logging());
        (dioService.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient dioClient) {
          dioClient.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return dioClient;
        };
        // print("create address request body : $request");
        var response =
            await dioService.post('/customer/shipping/create', data: request);
        // print("create delivery address response : ${response.toString()}");
        if (response.statusCode == 200) {
          ShippingAddressResponse getAddressResponse =
              ShippingAddressResponse.fromJson(response.data);
          if (getAddressResponse.status == Strings.success) {
            Utils.showSnackbar(
                context,
                Strings.success,
                getAddressResponse.message.toString().toTitleCase(),
                AppColors.green);
            fetchAddress(context);
          } else {
            return Utils.showSnackbar(
                context,
                Strings.error,
                getAddressResponse.message.toString().toTitleCase(),
                AppColors.red);
          }
        } else {
          return Utils.showSnackbar(context, Strings.error,
              response.data['message'].toString().toTitleCase(), AppColors.red);
        }
      } catch (e) {
        return Utils.showSnackbar(
            context, Strings.error, e.toString(), AppColors.red);
      } finally {
        isLoading(false);
        clickToShopItem(
          context,
          amount,
          data,
        );
      }
    }
  }

  void orderCheckOut(BuildContext context, double amount, String transactionId,
      ProductData data) async {
    var addresss =
        addresses.firstWhere((element) => element.isDefaultAddress == 'true');
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': sdkKey.value,
        'amount': amount,
        'currency': "USD",
        'customer_id': Storage.getValue(Constants.customerID),
        'shipping_fee': "0.00",
        'tax': "0.00",
        'transaction_id': transactionId,
        'zip': addresss.zip ?? zipCodeController.text.toString(),
        'street_address':
            addresss.streetAddress ?? streetAddressController.text.toString(),
        'address_name': addressName.text.toString(),
        'city': addresss.city ?? city.text.toString(),
        'state': addresss.state ?? state.text.toString(),
        'country': addresss.country ?? country.text.toString(),
        'save_address': "false",
        'is_default_address': addresss.isDefaultAddress,
        'product_ids': [data.id],
        'quantity_list': ["1"],
        'meta': {
          "address":
              addresss.streetAddress ?? streetAddressController.text.toString()
        }
      };
      // print(
      //     "checkout order request body : $request and url is: ${sdkbase.value}");
      Dio dioService = Dio();
      dioService = Dio(BaseOptions(
        baseUrl: sdkbase.value,
      ))
        ..interceptors.add(Logging());
      (dioService.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (HttpClient dioClient) {
        dioClient.badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
        return dioClient;
      };
      var response =
          await dioService.post('/customer/orders/checkout', data: request);
      if (response.statusCode == 200) {
        OrderCheckoutResponse getAddressResponse =
            OrderCheckoutResponse.fromJson(response.data);
        if (getAddressResponse.status == Strings.success) {
          // return Utils.showSnackbar(
          //     context,
          //     Strings.success,
          //     getAddressResponse.message.toString().toTitleCase(),
          //     AppColors.green);
        } else {
          return Utils.showSnackbar(
              context,
              Strings.error,
              getAddressResponse.message.toString().toTitleCase(),
              AppColors.red);
        }
      } else {
        isLoading(false);
        return Utils.showSnackbar(
            context, Strings.error, response.data['message'], AppColors.red);
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
    // print('oneclick api key is : $oneClick');
    // print('sdk api key is : $sdkKey');
    // print('the base url is :${sdkbase.value}');
    CheckoutButton.depositsCheckout(context,
        CheckoutButton.ButtonConfig(amount: amount, buttonColor: '0DB9E9'),
        userEmail: Storage.getValue(Constants.customerEmail),
        apiKey: oneClick.value,
        envMode: Constants.setOneClickEnvMode(), chargeFundsResponse: (response) {
      print( "response from oneclickpayment is : ${response.toJson().toString()}");
      //load deposit-ecommerce env variable and mode
      Utils.getEnviromentMode();
      Utils.loadEnvFile();
      if (response.data != null) {
        orderCheckOut(context, amount, response.data!.transactionId!, data);
        fetchAddress(context);
      }
      shopContext?.checkoutEvent.add(response);
      //load one-click env variables and mode
      dotenv.load(fileName:'packages/deposits_oneclick_checkout/lib/app/common/assets/.env');
    });
  }
}
