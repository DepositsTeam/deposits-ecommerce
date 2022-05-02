import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ProductsController extends GetxController {

  var totalResults = 0.obs;
  var totalQuantity = 0.obs;
  var totalSold = 0.obs;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var isSearchItemVisible = false.obs;
  final searchController = TextEditingController();
  RxList<ProductData> tempItems = <ProductData>[].obs;
  RxList<ProductData> items = <ProductData>[].obs;
  ScrollController scrollController = ScrollController();
  var hideShowLogo = false.obs;
  final DepositsEcommerceContext? shopContext;

  ProductsController({this.shopContext});

  @override
  void onInit() async {
    scrollController.addListener(scrollListener);
    super.onInit();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   isError(false);
  // }

  scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      //get to the bottom
      hideShowLogo(true);
      update();
    }
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      //get to the top
      hideShowLogo(false);
      update();
    }
  }

  void fetchProducts(BuildContext context, String? merchantId) async {
    tempItems.clear();
    items.clear();
    totalQuantity = 0.obs;
    totalResults = 0.obs;
    totalSold = 0.obs;
    try {
      isLoading(true);
      var request = {
        'api_key': await Constants.apiKey(),
        'merchant_id': merchantId ?? Storage.getValue(Constants.merchantID)
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
        if (items.isNotEmpty) {
          items.forEach((val) {
            totalQuantity += int.parse(val.quantity!);
          });
          items.forEach((val) {
            totalSold += int.parse(val.numberSold.toString().split(".")[0]);
          });
        }
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
    }
    update();
  }

  void addProduct(BuildContext context) {
    Utils.navigationPush(
        context,
        AddProducts(
          shopContext: shopContext
        ));
  }

  void gallery(BuildContext context, Widget initialScreen) {
    Utils.navigationPush(
        context,
        AssetsGallery());
  }

  void editProduct(
      BuildContext context, ProductData data) {
    Utils.navigationPush(
        context,
        EditProduct(data: data,
        ));
  }

  hideShowSearch() {
    isSearchItemVisible.value = !isSearchItemVisible.value;
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
