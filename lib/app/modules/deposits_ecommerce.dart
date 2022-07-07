import 'dart:io';
import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:rxdart/subjects.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

//functions to be used by other developers
class DepositsEcommerceContext {
  late SetupMerchantResponse merchant;
  final String? depositsUserID;
  final int? merchantID;
  final String? apiKey;
  final bool? envMode;

  final setupShopEvent = BehaviorSubject<SetupMerchantResponse>();
  final checkoutEvent = BehaviorSubject<dynamic>();
  final addProductEvent = BehaviorSubject<dynamic>();

  DepositsEcommerceContext(
      {this.depositsUserID, this.merchantID, this.apiKey, this.envMode});

  // void productionMode(String isProd) {
  //   Storage.saveValue(Constants.envMode, isProd);
  // }

  Future init() async {
    Utils.loadEnvFile();
    await GetStorage.init("deposits-ecommerce");
    await Storage.saveValue(Constants.envMode, envMode);
    await Storage.saveValue(Constants.subClientApiKey, apiKey);
    await Storage.saveValue(Constants.merchantID, merchantID.toString());
  }

  Future<SetupMerchantResponse?> setupShop(
    BuildContext context,
  ) async {
    await Utils.navigationPush(context, SetUpShop(shopContext: this));
  }

  Future showDashboard(BuildContext context) async {
    await init();
    print(Storage.storage.getKeys());
    String merchantID = Storage.getValue(Constants.merchantID).toString();
    await Utils.navigationPush(context, Dashboard(merchantID: "$merchantID"));
  }

  Future showShop(BuildContext context,
      {required int? customerID, required String? customerEmail}) async {
    await init();
    Storage.saveValue(Constants.customerID, customerID.toString());
    Storage.saveValue(Constants.customerEmail, customerEmail);
    await Utils.navigationPush(
        context,
        Shops(
          customerId: "$customerID",
          shopContext: this,
        ));
  }

  Future showProduct(BuildContext context,
      {required ProductData data,
      required int? customerID,
      required String? customerEmail}) async {
    await init();
    await Storage.saveValue(Constants.customerID, customerID.toString());
    await Storage.saveValue(Constants.customerEmail, customerEmail);
    await Utils.navigationPush(
        context,
        ShopItemDetail(
          data: data,
          shopContext: this,
        ));
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

//initial function to call the deposit shownow button
Widget depositsMerchantWidget(
  BuildContext context,
  ButtonConfig buttonConfig, {
  required String merchantID,
  required bool envMode,
  required String apiKey,
}) {
  HttpOverrides.global = MyHttpOverrides();
  GetStorage.init("deposits-ecommerce");
  Utils.loadEnvFile();
  Storage.removeValue(Constants.customColor);
  Storage.saveValue(Constants.customColor, buttonConfig.buttonColor);
  return ShopButton(
    context: context,
    buttonConfig: buttonConfig,
    merchantID: merchantID,
    envMode: envMode,
    apiKey: apiKey,
  );
}

//initial this on any page you line to implement the featuredlist on.
Widget depositsCustomerWidget(
  BuildContext context, {
  required String merchantId,
  required String customerID,
  required String apiKey,
  required String customColor,
  required bool envMode,
}) {
  GetStorage.init("deposits-ecommerce");
  Utils.loadEnvFile();
  Storage.removeValue(Constants.customColor);
  Storage.saveValue(Constants.customColor, customColor);
  return HorizontalShopContainer(
    context: context,
    envMode: envMode,
    merchantId: merchantId,
    customerID: customerID,
    apiKey: apiKey,
  );
}

class HorizontalShopContainer extends StatefulWidget {
  final BuildContext? context;
  final String merchantId;
  final String customerID;
  final String apiKey;
  final bool envMode;

  const HorizontalShopContainer({
    Key? key,
    this.context,
    required this.envMode,
    required this.merchantId,
    required this.customerID,
    required this.apiKey,
  }) : super(key: key);

  @override
  State<HorizontalShopContainer> createState() =>
      _HorizontalShopContainerState();
}

class _HorizontalShopContainerState extends State<HorizontalShopContainer>
    with WidgetsBindingObserver {
  late final DepositsEcommerceContext? shopContext = DepositsEcommerceContext();
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    Storage.removeValue(Constants.merchantID);
    Storage.removeValue(Constants.customerID);
    Storage.removeValue(Constants.subClientApiKey);
    Storage.removeValue(Constants.envMode);

    Storage.saveValue(Constants.merchantID, widget.merchantId);
    Storage.saveValue(Constants.customerID, widget.customerID);
    Storage.saveValue(Constants.subClientApiKey, widget.apiKey);
    Storage.saveValue(Constants.envMode, widget.envMode);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomRowTextWidget(
          title: Strings.featuredListing,
          titleStyle: const TextStyle(
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.w600,
              color: AppColors.black),
          titleOnTap: () {},
          subtitle: Strings.seeAll,
          subtitleStyle: TextStyle(
              fontSize: Dimens.fontSize16,
              fontWeight: FontWeight.w600,
              color: AppColors.borderButtonColor2()),
          subTitleOnTap: () {
            Utils.navigationPush(context,
                Shops(customerId: widget.customerID, shopContext: shopContext));
            Storage.removeValue(Constants.merchantID);
            Storage.removeValue(Constants.customerID);
            Storage.removeValue(Constants.subClientApiKey);
            Storage.removeValue(Constants.envMode);

            Storage.saveValue(Constants.merchantID, widget.merchantId);
            Storage.saveValue(Constants.customerID, widget.customerID);
            Storage.saveValue(Constants.subClientApiKey, widget.apiKey);
            Storage.saveValue(Constants.envMode, widget.envMode);
          },
        ),
        verticalSpaceMedium,
        ShopItems(
            merchantID: widget.merchantId,
            customerID: widget.customerID,
            apiKey: widget.apiKey,
            envMode: widget.envMode),
        // CustomSvgimage(image: AppImages.depositsLogo),
        verticalSpaceMedium,
      ],
    );
  }
}

class ShopItems extends StatefulWidget {
  final String merchantID;
  final String customerID;
  final String apiKey;
  final bool envMode;
  const ShopItems({
    Key? key,
    required this.merchantID,
    required this.customerID,
    required this.apiKey,
    required this.envMode,
  }) : super(key: key);

  @override
  State<ShopItems> createState() => _ShopItemsState();
}

class _ShopItemsState extends State<ShopItems> with WidgetsBindingObserver {
  DepositEcommerceController controller = Get.put(DepositEcommerceController());
  late final DepositsEcommerceContext? shopContext = DepositsEcommerceContext();

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchProducts(
        context, widget.apiKey, widget.merchantID, widget.customerID);
    controller.getCustumerDetails(
        context, widget.merchantID, widget.customerID);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    controller.isError(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchProducts(
          context, widget.apiKey, widget.merchantID, widget.customerID);
      controller.getCustumerDetails(
          context, widget.merchantID, widget.customerID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 250,
          child: controller.isLoading.value
              ? Utils.loader()
              : controller.isError.value
                  ? CustomNoInternetRetry(
                      message: controller.errorMessage.value,
                      onPressed: () {
                        controller.fetchProducts(context, widget.apiKey,
                            widget.merchantID, widget.customerID);
                        controller.getCustumerDetails(
                            context, widget.merchantID, widget.customerID);
                      },
                      title: Strings.error,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, i) {
                        var item = controller.items[i];
                        return InkWell(
                          onTap: () {
                            Utils.navigationPush(
                                context,
                                ShopItemDetail(
                                  data: item,
                                  shopContext: shopContext,
                                ));
                            Storage.removeValue(Constants.merchantID);
                            Storage.removeValue(Constants.customerID);
                            Storage.removeValue(Constants.subClientApiKey);
                            Storage.removeValue(Constants.envMode);

                            Storage.saveValue(
                                Constants.merchantID, widget.merchantID);
                            Storage.saveValue(
                                Constants.customerID, widget.customerID);
                            Storage.saveValue(
                                Constants.subClientApiKey, widget.apiKey);
                            Storage.saveValue(
                                Constants.envMode, widget.envMode);
                          },
                          child: Container(
                            width: 170,
                            padding: const EdgeInsets.only(right: 18),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150.0,
                                  child: PNetworkImage(
                                    item.assets!.isNotEmpty
                                        ? item.assets![0].url!
                                        : Constants.noAssetImageAvailable,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                ),
                                verticalSpaceSmall,
                                CustomTextTag(
                                  text: item.status!.toTitleCase(),
                                  height: 27,
                                  width: 100,
                                  status: item.status,
                                ),
                                verticalSpaceSmall,
                                CustomText(
                                  text: item.name! + " " + item.description!,
                                  font: Dimens.fontSize16,
                                  fntweight: FontWeight.w300,
                                  ellipsis: TextOverflow.ellipsis,
                                ),
                                verticalSpaceSmall,
                                CustomText(
                                  text: "\$" + item.price!,
                                  font: Dimens.fontSize18,
                                  fntweight: FontWeight.w600,
                                  ellipsis: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
        ));
  }
}

class DepositsApi {
  /// Parameter, [sdkApiKey] is the apiKey from the console for deposits super vendor.
  late String? sdkApiKey;

  /// Parameter, [apiKey] is the apiKey from the console for the host application.
  final String apiKey;

  final bool isProduction;

  bool? envLoaded;

  String? baseUrl;

  /// Parameter(Optional) [isDebug], tells the library if it should _printToLog debug logs.
  /// Useful if you are debuging or in development.
  late bool isDebug;

  DepositsApi(
      {required this.apiKey,
      required this.isProduction,
      this.isDebug = false}) {
    // init function
    envLoaded = false;
    loadEnv();
  }

  loadEnv() async {
    await dotenv.load(
        fileName: 'packages/deposits_ecommerce/lib/app/common/assets/.env');
    envLoaded = true;
  }

  setBaseUrl() async {
    if (envLoaded == false) {
      await loadEnv();
    }
    if (isProduction == true) {
      baseUrl = dotenv.env['baseUrlLive'].toString();
    } else {
      baseUrl = dotenv.env['baseUrlSandbox'].toString();
    }
  }

  setSdkApiKey() async {
    if (isProduction == true) {
      sdkApiKey = dotenv.env['sdkApiKeyLive'].toString();
    } else {
      sdkApiKey = dotenv.env['sdkApiKeySandbox'].toString();
    }
  }

  void _printToLog(String message) {
    if (isDebug) {
      // ignore: avoid_print
      print("DepositsApi LOG : " + message);
    }
  }

  /// get categories
  Future getCategories() async {
    var apiResponse = await post("/merchant/categories", {});
    return apiResponse;
  }

  /// setup merchant
  Future setupMerchant(depositUserId, name, description, supportEmail, category,
      zip, streetAddress, city, state, country) async {
    var data = {
      'deposit_user_id': depositUserId,
      'name': name,
      'description': description,
      'support_email': supportEmail,
      'category': category,
      'zip': zip,
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'country': country,
    };
    var apiResponse = await post("/merchant/setup-merchant", data);
    return apiResponse;
  }

  /// get merchant
  Future getMerchant(id) async {
    var data = {'merchant_id': id};
    var apiResponse = await post("/merchant", data);
    return apiResponse;
  }

  /// get merchant info
  Future getMerchantInfo(id) async {
    var data = {'merchant_id': id};
    var apiResponse = await post("/merchant/get-info", data);
    return apiResponse;
  }

  /// get merchant info
  Future getSelectedMerchants(merchantIds) async {
    var data = {'merchant_ids': merchantIds};
    var apiResponse = await post("/merchant/selected", data);
    return apiResponse;
  }

  /// update merchant
  Future updateMerchant(id, name, description, supportEmail, category, zip,
      streetAddress, city, state, country) async {
    var data = {
      'merchant_id': id,
      'name': name,
      'description': description,
      'support_email': supportEmail,
      'category': category,
      'zip': zip,
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'country': country,
    };
    var apiResponse = await post("/merchant/update", data);
    return apiResponse;
  }

  /// update merchant policy
  Future updateMerchantPolicy(id, returnPolicy, shippingPolicy) async {
    var data = {
      'merchant_id': id,
      'return_policy': returnPolicy,
      'shipping_policy': shippingPolicy,
    };
    var apiResponse = await post(
        "/merchant/update-merchant-shipping-and-return-policy", data);
    return apiResponse;
  }

  /// update merchant contact info
  Future updateMerchantContactInfo(id, contactInfo, contactAddress) async {
    var data = {
      'merchant_id': id,
      'contact_info': contactInfo,
      'contact_address': contactAddress,
    };
    var apiResponse =
        await post("/merchant/update-merchant-contact-and-address", data);
    return apiResponse;
  }

  /// update merchant shipping and tax info
  Future updateMerchantShippingAndTaxInfo(
      id, taxId, taxPercent, shippingFee) async {
    var data = {
      'merchant_id': id,
      'tax_id': taxId,
      'tax_percent': taxPercent,
      'shipping_fee': shippingFee,
    };
    var apiResponse = await post("/merchant/update-merchant-tax-and-fee", data);
    return apiResponse;
  }

  /// get merchant
  Future deleteMerchant(id) async {
    var data = {'merchant_id': id};
    var apiResponse = await post("/merchant/delete-merchant", data);
    return apiResponse;
  }

  /// createProduct
  Future createProduct(merchantId, sku, name, price, description, quantity,
      includeFeesTax, type, tax, shippingFee, assetIds, meta) async {
    var data = {
      'merchant_id': merchantId,
      'sku': sku,
      "name": name,
      "price": price,
      "description": description,
      "quantity": quantity,
      "include_fees_tax": includeFeesTax,
      "type": type,
      "tax": tax,
      "shipping_fee": shippingFee,
      "asset_ids": assetIds,
      "meta": meta
    };
    var apiResponse = await post("/merchant/products/create", data);
    return apiResponse;
  }

  /// createAsset
  Future createAsset(merchantId, file, name, description) async {
    var data = {
      'merchant_id': merchantId,
      'file': file,
      'name': name,
      'description': description,
    };
    var apiResponse = await post("/merchant/assets/create", data);
    return apiResponse;
  }

  // Customers

  /// createCustomer
  Future createCustomer(
      merchantId, email, firstName, lastName, gender, phoneNumber, meta) async {
    var data = {
      'merchant_id': merchantId,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'phone_number': phoneNumber,
      'meta': meta,
    };
    var apiResponse = await post("/merchant/customers/create", data);
    return apiResponse;
  }

  /// findCustomerOrCreate
  Future findCustomerOrCreate(
      merchantId, email, firstName, lastName, gender, phoneNumber, meta) async {
    var data = {
      'merchant_id': merchantId,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'phone_number': phoneNumber,
      'meta': meta,
    };
    var apiResponse = await post("/customer/find-or-save", data);
    return apiResponse;
  }

  /// findCustomer
  Future findCustomer(merchantId, email) async {
    var data = {
      'merchant_id': merchantId,
      'email': email,
    };
    var apiResponse = await post("/customer/find", data);
    return apiResponse;
  }

  /// getProducts
  Future getProducts(merchantId) async {
    var data = {
      'merchant_id': merchantId,
    };
    var apiResponse = await post("/customer/products/all", data);
    return apiResponse;
  }

  /// getProducts
  Future getProduct(merchantId, productId) async {
    var data = {
      'merchant_id': merchantId,
    };
    var apiResponse = await post("/customer/products/$productId", data);
    return apiResponse;
  }

  /// getFeaturedProducts
  Future getFeaturedProducts(merchantId) async {
    var data = {
      'merchant_id': merchantId,
    };
    var apiResponse = await post("/customer/products/featured", data);
    return apiResponse;
  }

  /// createOrder
  Future createOrder(
      merchantId,
      customerId,
      shippingFee,
      tax,
      transactionId,
      zip,
      streetAddress,
      city,
      state,
      country,
      saveAddress,
      isDefaultAddress,
      productIds,
      quantityList,
      meta) async {
    var data = {
      'merchant_id': merchantId,
      'customer_id': customerId,
      'shipping_fee': shippingFee,
      'tax': tax,
      'transaction_id': transactionId,
      'zip': zip,
      'street_address': streetAddress,
      'city': city,
      'state': state,
      'country': country,
      'save_address': saveAddress,
      'is_default_address': isDefaultAddress,
      'product_ids': productIds,
      'quantity_list': quantityList,
      'meta': meta,
    };
    var apiResponse = await post("/customer/orders/checkout", data);
    return apiResponse;
  }

  /// Make a custom get request to a DepositsApi endpoint, using DepositsApi SDK.
  Future<dynamic> get(String endPoint) async {
    await setBaseUrl();
    await setSdkApiKey();
    var url = "$baseUrl$endPoint";
    var httpResponse = await httpRequest("GET", url, []);
    return httpResponse;
  }

  /// Make a custom post request to DepositsApi, using DepositsApi SDK.
  Future<dynamic> post(String endPoint, Map data) async {
    await setBaseUrl();
    await setSdkApiKey();

    var url = "$baseUrl$endPoint";
    var httpResponse = await httpRequest("POST", url, data);
    return httpResponse;
  }

  httpRequest(type, url, data) async {
    // ignore: prefer_typing_uninitialized_variables
    var response, httpResponse;
    try {
      type = type.toString().toLowerCase();
      var headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      data['api_key'] = sdkApiKey;
      data['sub_client_api_key'] = apiKey;
      HttpClient client = HttpClient()
        ..badCertificateCallback =
            ((X509Certificate cert, String host, int port) => true);
      var ioClient = IOClient(client);

      if (type == 'get') {
        httpResponse = await ioClient.get(Uri.parse(url), headers: headers);
      } else if (type == 'delete') {
        httpResponse = await ioClient.delete(Uri.parse(url),
            body: json.encode(data), headers: headers);
      } else if (type == 'patch') {
        httpResponse = await ioClient.patch(Uri.parse(url),
            body: json.encode(data), headers: headers);
      } else {
        httpResponse = await ioClient.post(Uri.parse(url),
            body: json.encode(data), headers: headers);
      }
      _printToLog("$url");
      _printToLog("$data");
      if (httpResponse.statusCode == 200) {
        //
        response = json.decode(httpResponse.body);
      } else {
        response = {
          'status': 'error',
          'message':
              '${httpResponse.statusCode} error $url ${httpResponse.body}'
        };
      }
      if (response['message']
          .toString()
          .contains('SocketException: OS Error')) {
        response['message'] = 'Network Error';
      }
      if (response['message']
          .toString()
          .contains('No address associated with hostname')) {
        response['message'] = 'Connection Error';
      }
    } catch (error) {
      _printToLog("$error");
      var response = {'status': 'error', 'message': 'Error: $error $url'};
      if (response['message'].toString().contains('SocketException')) {
        response['message'] = 'Network Error';
      }
      if (response['message']
          .toString()
          .contains('No address associated with hostname')) {
        response['message'] = 'Connection Error';
      }
    }
    _printToLog("$response");
    return response;
  }
}
