import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:deposits_ecommerce/app/model/merchant_model/customer/create_response.dart';
import 'package:deposits_ecommerce/app/modules/merchant/all_customers/all_customers_controller.dart';
import 'package:intl/intl.dart';

class CreateCustomersController extends GetxController {
  var isError = false.obs;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  String gender = '';
  List<String> genderList = ['Male', 'Female'];
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();
  AllCustomersController allCustomersController = Get.find();

  @override
  void onInit() {
    email.text = '';
    firstName.text = '';
    lastName.text = '';
    phoneNumber.text = '';
    address.text = '';
    gender = genderList.first;
    email.addListener(() {
      update();
    });
    firstName.addListener(() {
      update();
    });
    lastName.addListener(() {
      update();
    });
    phoneNumber.addListener(() {
      update();
      address.addListener(() {
        update();
      });
    });
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    address.dispose();
  }

  bool validateInput() {
    if (email.text.isEmpty) {
      return false;
    } else if (firstName.text.isEmpty) {
      return false;
    } else if (lastName.text.isEmpty) {
      return false;
    } else if (phoneNumber.text.isEmpty) {
      return false;
    } else if (address.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void createCustomer(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'merchant_id': Storage.getValue(Constants.merchantID),
          'api_key': await Constants.apiKey(),
          'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
          'email': email.text.toString(),
          "first_name": firstName.text.toString(),
          "last_name": lastName.text.toString(),
          "gender": gender.toString(),
          "phone_number": phoneNumber.text.toString(),
          "meta": {"address": address.text.toString()},
        };
        var response = await DioClient().request(
            context: context,
            api: '/merchant/customers/create',
            method: Method.POST,
            params: request);
        CreateCustomerResponse createCustomerResponse =
            CreateCustomerResponse.fromJson(response);
        if (createCustomerResponse.status == Strings.success) {
          Storage.removeValue(Constants.customerID);
          Storage.saveValue(
              Constants.customerID, createCustomerResponse.data!.id.toString());
          // Utils.navigationPush(
          // context,
          // Shops(
          //   initialScreen: initialScreen,
          //   merchantId: Storage.getValue(Constants.merchantID),
          // ));
          Utils.navigationReplace(
              context,
              SuccessfulMgs(
                successTitle: Strings.customerCreatedSuccessfully,
                successMessage: DateFormat.jm().format(
                    DateTime.parse(DateTime.now().toString()).toLocal()),
              ));
          allCustomersController.fetchCustomers(context);
        } else {
          return Utils.showSnackbar(context, Strings.error,
              response['message'].toString().toTitleCase(), AppColors.red);
        }
      } catch (e) {
        return Utils.showSnackbar(
            context, Strings.error, e.toString(), AppColors.red);
      } finally {
        isLoading(false);
      }
      update();
    }
  }
}
