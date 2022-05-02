 
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AllPaymentsController extends GetxController {
var isLoading = false.obs;
RxList<OrderData> tempItems = <OrderData>[].obs;
  RxList<OrderData> items = <OrderData>[].obs;
   final searchController = TextEditingController();



  void fetchOrders(BuildContext context) async {
    tempItems.clear();
    items.clear();
    try {
      isLoading(true);
      var request = {
        'api_key': await Constants.apiKey(),
        'merchant_id': Storage.getValue(Constants.merchantID)
      };
      var response = await DioClient().request(context: context,
          api: '/merchant/orders/get', method: Method.POST, params: request);

      AllOrdersResponse allOrdersResponse =
          AllOrdersResponse.fromJson(response);
      if (allOrdersResponse.status == Strings.success) {
        tempItems.addAll(allOrdersResponse.data!.obs);
        items.addAll(tempItems);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
    }
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
      update();
      return;
    } else {
      items.clear();
      items.addAll(tempItems);
      update();
    }
  }

}