import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class AddTaxFeeController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final taxId = TextEditingController();
  final taxPercentage = TextEditingController();
  final extraFee = TextEditingController();

     @override
  void onInit() {
    super.onInit();
    taxId.text = '';
    taxPercentage.text = '';
    extraFee.text = '';
    taxId.addListener(() {
      update();
    });
    taxPercentage.addListener(() {
     update();
    });
    extraFee.addListener(() {
      update();
    });
  }

 @override
  void dispose() {
    super.dispose();
    taxId.dispose();
    taxPercentage.dispose();
    extraFee.dispose();
  }

   bool validateInput( ) {
    if (taxId.text.isEmpty) {
      return false;
    } else if (taxPercentage.text.isEmpty) {
      return false;
    } else if (extraFee.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

    void addTaxFee(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      isLoading.value = true;
      Future.delayed(const Duration(seconds: 5), () {
        isLoading.value = false;
        Utils.navigationPush(context, SuccessfulMgs(
                  successTitle: Strings.taxAddedSuccessfully,
                  successMessage: DateFormat.jm().format(DateTime.parse(DateTime.now().toString()).toLocal()),
                  ));
      });
    }
  }

}