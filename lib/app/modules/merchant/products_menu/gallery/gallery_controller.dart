
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AssetsGalleryController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  RxList<Asset> allAssets = <Asset>[].obs;
  RxList<Asset> selectedAssets = <Asset>[].obs;

    void addProduct(BuildContext context) {
    Utils.navigationPush(
        context,
        AddProducts());
  }

  void fetchGallery(BuildContext context)async{
      try{
    isLoading(true);
    var request = {
      'merchant_id': Storage.getValue(Constants.merchantID),
      'api_key': await Constants.apiKey()
    };
    var response = await DioClient()
        .request(context: context,api: '/merchant/assets/get', method: Method.POST, params: request);

    AllAssetsResponse allAssetsResponse =
        AllAssetsResponse.fromJson(response);
    if (allAssetsResponse.status == Strings.success) {
      allAssets = allAssetsResponse.data!.obs;
    } else {
       isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
      return Utils.showSnackbar(
          context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
    }
    }catch(e){
       isError(true);
        errorMessage.value = e.toString().toTitleCase();
      return Utils.showSnackbar(
            context, Strings.error, e.toString().toTitleCase(), AppColors.red);
    } finally {
      isLoading(false);
    }
    update();
  }

}