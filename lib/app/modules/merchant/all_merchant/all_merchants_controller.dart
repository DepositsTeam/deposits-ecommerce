import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AllMerchantsController extends GetxController {
  var isError = false.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  final searchController = TextEditingController();
  RxList<MerchantData> tempAllMerchants = <MerchantData>[].obs;
  RxList<MerchantData> allMerchants = <MerchantData>[].obs;


  void fetchMerchants(BuildContext context) async {
    tempAllMerchants.clear();
    allMerchants.clear();
    try {
      isLoading(true);
      var request = {
        'api_key': await Constants.apiKey(),
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/all',
          method: Method.POST,
          params: request);

      AllMerchantsResponse merchantResponse =
          AllMerchantsResponse.fromJson(response);
      if (merchantResponse.status == Strings.success) {
        allMerchants.addAll(merchantResponse.data!.obs);
        tempAllMerchants.addAll(merchantResponse.data!.obs);
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } catch (e) {
      isError(true);
      errorMessage.value = e.toString().toString().toTitleCase();
      return Utils.showSnackbar(
          context, Strings.error, e.toString().toTitleCase(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
  }

  void filterSearchResults(String query) {
    RxList<MerchantData> dummySearchList = <MerchantData>[].obs;
    dummySearchList.addAll(tempAllMerchants);
    if (query.isNotEmpty) {
      RxList<MerchantData> dummyListData = <MerchantData>[].obs;
      for (var item in dummySearchList) {
        if (item.status!.toLowerCase().contains(query) ||
            item.status!.toUpperCase().contains(query) ||
            item.name!.toLowerCase().contains(query) ||
            item.name!.toUpperCase().contains(query)) {
          dummyListData.add(item);
        }
      }
      allMerchants.clear();
      allMerchants.addAll(dummyListData);
      update();
      return;
    } else {
      allMerchants.clear();
      allMerchants.addAll(tempAllMerchants);
      update();
    }
  }

  void setUpShop(
    BuildContext context,
  ) {
    DepositsEcommerceContext depositsEcommerceContext =
        DepositsEcommerceContext(
      envMode: true,
    );
    depositsEcommerceContext.setupShop(context);
  }
}
