import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:http/http.dart' as http;

class SupportController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  final formKey = GlobalKey<FormState>();
  String productType = '';
  List<String> productTypeList = [];
  final orderController = TextEditingController();
  final issueController = TextEditingController();
  Rx<OrderData> chosenOrder = OrderData().obs;
  final RxList<OrderData> orderList = <OrderData>[].obs;
  BuildContext? context;

  @override
  void dispose() {
    super.dispose();
    issueController.dispose();
    orderController.dispose();
    productTypeList.clear();
    orderList.clear();
  }

  void fetchSupportCategory(BuildContext context) async {
    productTypeList.clear();
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey()
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/support/get-support-message-categories',
          method: Method.POST,
          params: request);

      ProductCategoryResponse productCategoryResponse =
          ProductCategoryResponse.fromJson(response);
      if (productCategoryResponse.status == Strings.success) {
        productTypeList.addAll(productCategoryResponse.data!);
        productType = productTypeList.first;
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

  Future<List<OrderData>> getUserSuggestions(String query) async {
    var request = {
      'api_key': await Constants.apiKey(),
      'merchant_id': Storage.getValue(Constants.merchantID)
    };
    final url = Uri.parse('${await Constants.baseUrl()}/merchant/orders/get');
    final response = await http.post(url, body: request);

    if (response.statusCode == 200) {
      var jsonString = response.body;
      AllOrdersResponse allContestants =
          AllOrdersResponse.fromJson(json.decode(jsonString));
      orderList.clear();
      orderList.addAll(allContestants.data!.obs);
      return orderList.where((user) {
        final nameLower = user.products![0].name!.toLowerCase();
        final queryLower = query.toLowerCase();

        return nameLower.contains(queryLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  void sendMg(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'merchant_id': Storage.getValue(Constants.merchantID),
          'api_key': await Constants.apiKey(),
          'category': productType,
          'order_id': chosenOrder.value.id!,
          'description': issueController.text.toString(),
        };
        var response = await DioClient().request(
            context: context,
            api: '/merchant/support/create',
            method: Method.POST,
            params: request);

        // SupportResponse supportResponse = SupportResponse.fromJson(response);
        Map<String, dynamic> respJson = Map<String, dynamic>.from(response);
        final String status = respJson['status'] as String;
        final String message = respJson['message'] as String;

        if (status == Strings.success) {
          Utils.navigationReplace(
              context,
              SuccessfulMgs(
                successTitle: Strings.mgsSent,
                successMessage: Strings.mgsSentSuccessfully,
              ));
        } else {
          return Utils.showSnackbar(context, Strings.error,
              message.toString().toTitleCase(), AppColors.red);
        }
      } catch (e) {
        return Utils.showSnackbar(
            context, Strings.error, e.toString().toTitleCase(), AppColors.red);
      } finally {
        isLoading(false);
      }
    }
  }

  bool validateInput() {
    if (issueController.text.isEmpty) {
      return false;
    }
    return true;
  }
}
