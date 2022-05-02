import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AllCustomersController extends GetxController {
  var isError = false.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  final searchController = TextEditingController();
  RxList<CustomerData> tempAllCustomers = <CustomerData>[].obs;
  RxList<CustomerData> allCustomers = <CustomerData>[].obs;

  void fetchCustomers(BuildContext context) async {
    tempAllCustomers.clear();
    allCustomers.clear();
    try {
      isLoading(true);
      var request = {
        'api_key': await Constants.apiKey(),
        'merchant_id' : Storage.getValue(Constants.merchantID)
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/customers/get',
          method: Method.POST,
          params: request);

      AllCustomersResponse customersResponse=
          AllCustomersResponse.fromJson(response);
      if (customersResponse.status == Strings.success) {
        allCustomers.addAll(customersResponse.data!.obs);
        tempAllCustomers.addAll(customersResponse.data!.obs);
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } catch (e) {
      isError(true);
      errorMessage.value = e.toString().toTitleCase();
      return Utils.showSnackbar(
          context, Strings.error, e.toString().toTitleCase(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
  }

  void filterSearchResults(String query) {
    RxList<CustomerData> dummySearchList = <CustomerData>[].obs;
    dummySearchList.addAll(tempAllCustomers);
    if (query.isNotEmpty) {
      RxList<CustomerData> dummyListData = <CustomerData>[].obs;
      for (var item in dummySearchList) {
        if (item.firstName!.toLowerCase().contains(query) ||
            item.firstName!.toUpperCase().contains(query) ||
            item.lastName!.toLowerCase().contains(query) ||
            item.lastName!.toUpperCase().contains(query)) {
          dummyListData.add(item);
        }
      }
      allCustomers.clear();
      allCustomers.addAll(dummyListData);
      update();
      return;
    } else {
      allCustomers.clear();
      allCustomers.addAll(tempAllCustomers);
      update();
    }
  }

  void addCustomer(BuildContext context,) {
    Utils.navigationPush(
        context,
        CreateCustomer());
  }
}
