import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class HomeMenuController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var totalOrders = 0.obs;
  var totalSalesWhole = '';
  var totalSalesDecimal = '';
  var formatter = NumberFormat('#,###,000');
  RxList<OrderData> tempItems = <OrderData>[].obs;
  RxList<OrderData> items = <OrderData>[].obs;
  ScrollController scrollController = ScrollController();
  var hideShowLogo = false.obs;

  @override
  void onInit() async {
    scrollController.addListener(scrollListener);
    super.onInit();
  }

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

  void fetchOrders(BuildContext context, String? merchantID) async {
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
        items.addAll(tempItems);
        totalOrders = items.length.obs;
        double totalSales = 0.00;
        if (items.isNotEmpty) {
          for (var val in items) {
            totalSales += double.parse(val.amount!.replaceAll(',', ''));
          }
        }
        var tt = (totalSales).toStringAsFixed(2).split(".")[0];
        totalSalesWhole =
            tt.toString()=='0' ? '0' :formatter.format(double.parse(tt)).toString();
        totalSalesDecimal = totalSales.toStringAsFixed(2).split(".")[1];
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
}
