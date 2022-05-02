import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class EcomPaymentsController extends GetxController {
  var totalResults = 0.obs;
  var totalOrdersSelected = 0.obs;
  var pendingBalanceWhole = '';
  var pendingBalanceDecimal = '';
  var walletBalanceWhole = '';
  var walletBalanceDecimal = '';
  var isLoading = false.obs;
  var isBottomLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var isExportSelector = false.obs;
  var isSearchItemVisible = false.obs;
  final searchController = TextEditingController();
  RxList<OrderData> tempItems = <OrderData>[].obs;
  RxList<OrderData> items = <OrderData>[].obs;
  RxList<OrderData> mainItemList = <OrderData>[].obs;
  RxList<OrderData> exportData = <OrderData>[].obs;
  final RxList<String> paymentIds = <String>[].obs;
  Rx<MerchantData> merchantData = MerchantData().obs;

//bottom sheet configration
  final formKey = GlobalKey<FormState>();
  List<String> paymentStatusList = ['Completed', 'Pending', 'Failed'];
  String paymentStatus = '';
  var isFilterLoading = false.obs;
  final paymentIdController = TextEditingController();
  final paymentDate = TextEditingController();
  final amountController = TextEditingController();
  final productNameController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var hideShowLogo = false.obs;

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
  bool validateInput() {
    if (paymentDate.text.isNotEmpty) {
      return true;
    }
    if (paymentIdController.text.isNotEmpty) {
      return true;
    }
    if (amountController.text.isNotEmpty) {
      return true;
    }
    if (productNameController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    scrollController.addListener(scrollListener);
    paymentIdController.text = '';
    amountController.text = '';
    productNameController.text = '';
    paymentStatus = paymentStatusList.first;
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    items.clear();
    tempItems.clear();
    paymentIds.clear();
    mainItemList.clear();
    exportData.clear();
  }

  Future<void> loadContent(BuildContext context, String merchantID) async {
    await fetchOrders(context, merchantID);
    await fetchBalance(context, merchantID);
  }

  Future<void> fetchBalance(BuildContext context, String? merchantID) async {
    try {
      isLoading(true);
      var request = {
        'merchant_id': merchantID ?? Storage.getValue(Constants.merchantID),
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
        //get wallet balance
        walletBalanceWhole =
            merchantData.value.walletAmount.toString().split(".")[0];
        walletBalanceDecimal =
            merchantData.value.walletAmount.toString().split(".")[1];
        //get
        pendingBalanceWhole =
            merchantData.value.walletAmountPending.toString().split(".")[0];
        pendingBalanceDecimal =
            merchantData.value.walletAmountPending.toString().split(".")[1];
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

  Future<void> fetchOrders(BuildContext context, String? merchantID) async {
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
          api: '/merchant/orders/get',
          method: Method.POST,
          params: request);

      AllOrdersResponse allOrdersResponse =
          AllOrdersResponse.fromJson(response);
      if (allOrdersResponse.status == Strings.success) {
        tempItems.addAll(allOrdersResponse.data!.obs);
        items.addAll(allOrdersResponse.data!.obs);
        mainItemList.addAll(allOrdersResponse.data!.obs);
        totalResults = items.length.obs;
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

  hideShowSearch() {
    isSearchItemVisible.value = !isSearchItemVisible.value;
  }

  void exportSeletedOrders(BuildContext context, List<OrderData> order) async {
    final List<String> exportSelectedIds = [];
    exportSelectedIds.clear();
    for (var item in order) {
      exportSelectedIds.add(item.id!.toString());
    }
    try {
      isLoading(true);
      isBottomLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey(),
        'order_ids': exportSelectedIds
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/orders/export',
          method: Method.FORM,
          payloadObj: request);

      Map<String, dynamic> respJson = Map<String, dynamic>.from(response);
      final String status = respJson['status'] as String;
      final String message = respJson['message'] as String;

      if (status == Strings.success) {
        Utils.showSnackbar(context, status.toString().toTitleCase(),
            message.toString().toTitleCase(), AppColors.green);
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        Utils.showSnackbar(context, Strings.error,
            message.toString().toTitleCase(), AppColors.red);
      }
    } catch (e) {
      return Utils.showSnackbar(
          context, Strings.error, e.toString().toTitleCase(), AppColors.red);
    } finally {
      exportData.clear();
      paymentIds.clear();
      totalOrdersSelected = 0.obs;
      isExportSelector = false.obs;
      isLoading(false);
      isBottomLoading(false);
    }
  }

  updateExportList(int index, bool selectedOption) {
    OrderData orderData = items[index];
    if (selectedOption == true &&
        paymentIds.contains(orderData.id.toString())) {
      paymentIds.removeWhere((element) => element == orderData.id.toString());
      exportData.removeWhere((element) => element == orderData);
      totalOrdersSelected = paymentIds.length.obs;
    }
    if (selectedOption == true &&
        !paymentIds.contains(orderData.id.toString())) {
      paymentIds.add(orderData.id.toString());
      exportData.add(orderData);
      totalOrdersSelected = paymentIds.length.obs;
    } else {
      paymentIds.removeWhere((element) => element == orderData.id.toString());
      exportData.removeWhere((element) => element == orderData);
      totalOrdersSelected = paymentIds.length.obs;
    }
    update();
  }

  hideShowExportSelector() {
    isExportSelector.value = !isExportSelector.value;
  }

  void selectFilterResults(
      {required BuildContext context,
      required String paymentId,
      required String paymentStatus,
      required String amount,
      required String productName}) {
    Navigator.pop(context);

    items.clear();
    bool isSearchByPayId = paymentId.isNotEmpty;
    bool isSearchByStatus = paymentStatus.isNotEmpty;
    bool isSearchByAmount = amount.isNotEmpty;
    bool isSearchByProdName = productName.isNotEmpty;

    RxList<OrderData> sortList = <OrderData>[].obs;
    RxList<OrderData> tempSortList = <OrderData>[].obs;

    for (OrderData order in mainItemList) {
      if (isSearchByAmount &&
              double.parse(order.amount!) == double.parse(amount) ||
          isSearchByPayId &&
              order.uuid!.toLowerCase().contains(paymentId.toLowerCase()) ||
          isSearchByStatus &&
              order.status!
                  .toLowerCase()
                  .contains(paymentStatus.toLowerCase())) {
        sortList.add(order);
      } else if (isSearchByProdName &&
          order.products != null &&
          order.products!.length > 0) {
        for (ProductData prod in order.products!) {
          if (prod.name!.toLowerCase().contains(productName.toLowerCase())) {
            sortList.add(order);
            break;
          }
        }
      }
    }

    tempSortList.addAll(sortList);

    ///Sort by Payment ID
    if (isSearchByPayId) {
      for (OrderData order in sortList) {
        if (!order.uuid!.toLowerCase().contains(paymentId.toLowerCase())) {
          tempSortList.remove(order);
        }
      }
    }

    ///Sort by Amount
    if (isSearchByAmount) {
      for (OrderData order in sortList) {
        double amnt = double.parse(order.amount!);
        double searchAmnt = double.parse(amount);
        if (amnt != searchAmnt) {
          tempSortList.remove(order);
        }
      }
    }

    ///Sort by Payment Status
    if (isSearchByStatus) {
      for (OrderData order in sortList) {
        if (!order.status!
            .toLowerCase()
            .contains(paymentStatus.toLowerCase())) {
          tempSortList.remove(order);
        }
      }
    }

    ///Sort by Product Name
    if (isSearchByProdName) {
      for (OrderData order in sortList) {
        bool found = false;
        if (order.products != null && order.products!.length > 0) {
          for (ProductData prod in order.products!) {
            if (prod.name!.toLowerCase().contains(productName.toLowerCase())) {
              found = true;
              break;
            }
          }
          if (found) {
            break;
          }
        }
        if (!found) {
          tempSortList.remove(order);
        }
      }
    }
    items.addAll(tempSortList);
    update();
  }

  void filterSearchResults(String query) {
    RxList<OrderData> dummySearchList = <OrderData>[].obs;
    dummySearchList.addAll(tempItems);
    if (query.isNotEmpty) {
      RxList<OrderData> dummyListData = <OrderData>[].obs;
      for (var item in dummySearchList) {
        if (item.uuid!.toLowerCase().contains(query) ||
            item.uuid!.toUpperCase().contains(query) ||
            item.products![0].name!.toLowerCase().contains(query) ||
            item.products![0].name!.toUpperCase().contains(query)) {
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
