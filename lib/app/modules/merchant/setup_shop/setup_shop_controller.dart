import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:deposits_ecommerce/app/services/logging.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class SetUpShopController extends GetxController {
  var isLoading = false.obs;
  var isDepositsIdDerived = false.obs;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final storeName = TextEditingController();
  final storeDescription = TextEditingController();
  final email = TextEditingController();
  final streetAddressController = TextEditingController();
  final zipCodeController = TextEditingController();
  final country = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  List<String> storeCategoryList = [];
  var storeCategory = ''.obs;
  var depositsUserId = ''.obs;
  var depositsUserEmail = ''.obs;
  final DepositsEcommerceContext shopContext;

  SetUpShopController({
    required this.shopContext,
  }) {
    if (shopContext.depositsUserID != null) {
      depositsUserId.value = shopContext.depositsUserID.toString();
      isDepositsIdDerived.value = true;
      update();
    } else {
      isDepositsIdDerived.value = false;
      update();
    }
  }

  @override
  void onInit() async {
    email.text = '';
    storeName.text = '';
    streetAddressController.text = '';
    zipCodeController.text = '';
    country.text = '';
    state.text = '';
    city.text = '';

    email.addListener(() {
      update();
    });
    storeName.addListener(() {
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
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    storeName.dispose();
    streetAddressController.dispose();
    zipCodeController.dispose();
    country.dispose();
    state.dispose();
    city.dispose();
    email.dispose();
    // isDepositsIdDerived(false);
  }

  Future<List<String>> fetchStoreCategory(BuildContext context) async {
    try {
      isLoading(true);
      var request = {'api_key': await Constants.apiKey()};
      var response = await DioClient().request(
          context: context,
          api: '/merchant/categories',
          method: Method.POST,
          params: request);
      ProductCategoryResponse productCategoryResponse =
          ProductCategoryResponse.fromJson(response);
      if (productCategoryResponse.status == Strings.success) {
        storeCategoryList.addAll(productCategoryResponse.data!);
        storeCategory.value =
            storeCategoryList.isEmpty ? "" : storeCategoryList.first;
        update();
        return storeCategoryList;
      } else {
        Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
        return [];
      }
    } catch (e) {
      Utils.showSnackbar(
          context, Strings.error, e.toString().toTitleCase(), AppColors.red);
      return [];
    } finally {
      isLoading(false);
    }
  }

  void setUpShop(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading.value = true;
        var request = {
          'api_key': await Constants.apiKey(),
          'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
          'deposit_user_id': depositsUserId.value,
          'name': storeName.text.toString(),
          'description': storeDescription.text.toString(),
          'country': country.text.toString(),
          'support_email': depositsUserEmail.value,
          'category': storeCategory,
          'zip': zipCodeController.text.toString(),
          'street_address': streetAddressController.text.toString(),
          'city': city.text.toString(),
          'state': state.text.toString()
        };
        var response = await DioClient().request(
            context: context,
            api: '/merchant/setup-merchant',
            method: Method.POST,
            params: request);

        SetupMerchantResponse setupMerchantResponse =
            SetupMerchantResponse.fromJson(response);
        // Map<String, dynamic> respJson = Map<String, dynamic>.from(response);
        // final String status = respJson['status'] as String;
        // final String message = respJson['message'] as String;
        // final MerchantData setupData = MerchantData.fromJson(respJson["data"]);

        if (setupMerchantResponse.status == Strings.success) {
          Storage.removeValue(Constants.merchantID);
          Storage.saveValue(
              Constants.merchantID, setupMerchantResponse.data!.id.toString());
          Storage.saveValue(Strings.isStoreSetUpComplete, true);

          shopContext.setupShopEvent.add(setupMerchantResponse);

          Utils.navigationReplace(context,
              Dashboard(merchantID: setupMerchantResponse.data!.id.toString()));
        } else {
          return Utils.showSnackbar(
              context,
              Strings.error,
              setupMerchantResponse.message.toString().toTitleCase(),
              AppColors.red);
        }
      } on DioError catch (e) {
        return Utils.showSnackbar(context, Strings.error,
            Utils.handleErrorComing(e).toTitleCase(), Colors.red);
      } catch (e) {
        return Utils.showSnackbar(
            context, Strings.error, e.toString().toTitleCase(), AppColors.red);
      } finally {
        isLoading(false);
      }
      update();
    }
  }

  bool validateInput() {
    if (streetAddressController.text.isEmpty) {
      return false;
    } else if (storeName.text.isEmpty) {
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

  //--------------------------------------
  bool validateEmail() {
    if (email.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  //--------------------------------------
  void getDepositsEmail(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey2.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'email': email.text.toString(),
          'api_key': dotenv.env['apiEmailKey'].toString(),
        };
        Dio dioService = Dio();
        dioService = Dio(BaseOptions(
          baseUrl: dotenv.env['apiEmailBaseUrl'].toString(),
        ))
          ..interceptors.add(Logging());
        (dioService.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient dioClient) {
          dioClient.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return dioClient;
        };
        var response =
            await dioService.post('/get-user-from-email', data: request);
        if (response.statusCode == 200) {
          GetMerchantEmailResponse emailResponse =
              GetMerchantEmailResponse.fromJson(response.data);
          if (emailResponse.status == Strings.success) {
            // print(
            //     'derived deposits email : ${emailResponse.data!.id.toString()}');
            depositsUserId.value = emailResponse.data!.id.toString();
            depositsUserEmail.value = emailResponse.data!.email.toString();
            isDepositsIdDerived(true);

            Utils.showSnackbar(context, Strings.success, emailResponse.message!,
                AppColors.green);
          } else {
            isLoading(false);
            return Utils.showSnackbar(
                context, Strings.error, emailResponse.message!, AppColors.red);
          }
        } else {
          isLoading(false);
          return Utils.showSnackbar(
              context, Strings.error, "message", AppColors.red);
        }
      } on DioError catch (e) {
        return Utils.showSnackbar(context, Strings.error,
            Utils.handleErrorComing(e).toTitleCase(), Colors.red);
      } catch (e) {
        isLoading(false);
        return Utils.showSnackbar(
            context, Strings.error, e.toString().toTitleCase(), Colors.red);
      } finally {
        isLoading(false);
      }
      update();
    }
  }
  //--------------------------------------

}
