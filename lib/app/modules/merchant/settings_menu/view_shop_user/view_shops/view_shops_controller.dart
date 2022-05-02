import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ViewShopsController extends GetxController {
  final searchController = TextEditingController();
  RxList<ProductData> tempItems = <ProductData>[].obs;
  RxList<ProductData> items = <ProductData>[].obs;
  var totalResults = 0.obs;
  var isSearchItemVisible = false.obs;
  String availability = '';
  String price = '';
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  List<String> availabilityList = ['All', 'Active', 'Out of Stock'];
  List<String> priceList = [
    'Under \$100',
    'Between \$100 - \$500',
    'Above \$500'
  ];
  final formKey = GlobalKey<FormState>();
  Rx<MerchantData> merchantData = MerchantData().obs;

  hideShowSearch() {
    isSearchItemVisible.value = !isSearchItemVisible.value;
  }

  Future<void> loadContent(BuildContext context, String? merchantId) async {
    await fetchProducts(context, merchantId);
    await fetchMerchantDetails(context, merchantId);
  }

  Future<void> fetchProducts(BuildContext context, String? merchantID) async {
    tempItems.clear();
    items.clear();
    try {
      isLoading(true);
      var request = {
        'api_key': await Constants.apiKey(),
        'merchant_id': merchantID ?? Storage.getValue(Constants.merchantID)
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/products/get',
          method: Method.POST,
          params: request);

      GetProductsResponse getProductsResponse =
          GetProductsResponse.fromJson(response);
      if (getProductsResponse.status == Strings.success) {
        tempItems.addAll(getProductsResponse.data!.obs);
        items.addAll(tempItems);
        totalResults = items.length.obs;
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(true);
    }
    update();
  }

  Future<void> fetchMerchantDetails(
      BuildContext context, String? merchantId) async {
    try {
      isLoading(true);
      var request = {
        'merchant_id': merchantId ?? Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey()
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/get-info',
          method: Method.POST,
          params: request);

      GetSingleMerchantResponse merchantResponse =
          GetSingleMerchantResponse.fromJson(response);
      if (merchantResponse.status == Strings.success) {
        merchantData = merchantResponse.data!.obs;
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

  void filterShopItems(BuildContext context, String search1) {
    Navigator.pop(context);
    double priceForComparison = double.parse(price.replaceAll(',', ''));
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
      // autovalidate(false);
      RxList<ProductData> filteredItems = <ProductData>[].obs;
      if (search1.isNotEmpty) {
        if (search1 == 'All') {
          items.addAll(tempItems);
          totalResults = items.length.obs;
          update();
        } else {
          items.clear();
          filteredItems.assignAll(
              tempItems.where((element) => element.status == search1));
          items.addAll(filteredItems);
          totalResults = items.length.obs;
          isLoading.value = false;
          update();
        }
      } else {
        items.addAll(tempItems);
        totalResults = items.length.obs;
        update();
      }
    });
  }

  void filterSearchResults(String query) {
    RxList<ProductData> dummySearchList = <ProductData>[].obs;
    dummySearchList.addAll(tempItems);
    if (query.isNotEmpty) {
      RxList<ProductData> dummyListData = <ProductData>[].obs;
      for (var item in dummySearchList) {
        if (item.status!.toLowerCase().contains(query) ||
            item.status!.toUpperCase().contains(query) ||
            item.name!.toLowerCase().contains(query) ||
            item.name!.toUpperCase().contains(query)) {
          dummyListData.add(item);
        }
      }
      items.clear();
      items.addAll(dummyListData);
      totalResults = items.length.obs;
      update();
      return;
    } else {
      items.clear();
      items.addAll(tempItems);
      totalResults = items.length.obs;
      update();
    }
  }
}
