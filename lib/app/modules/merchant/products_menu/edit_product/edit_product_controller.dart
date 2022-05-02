import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:http/http.dart' as http;
class EditProductController extends GetxController {
  var isLoading = false.obs;
  var autovalidate = false.obs;
  var isIncludeTaxFee = true.obs;
  final formKey = GlobalKey<FormState>();
  final productName = TextEditingController();
  final productPrice = TextEditingController();
  String productType = '';
  List<String> productTypeList = [];
  final productQuantity = TextEditingController();
  final productDetails = TextEditingController();
  final enterTax = TextEditingController();
  final extraFee = TextEditingController();
  final RxList<String> selectedImagePaths = <String>[].obs;
  ProductsController productsController = Get.find();

  @override
  void dispose() {
    super.dispose();
    productName.dispose();
    productPrice.dispose();
    productQuantity.dispose();
    productDetails.dispose();
    enterTax.dispose();
    extraFee.dispose();
  }

  void toggleIsIncludeTaxFee(bool value) {
    isIncludeTaxFee.value = value;
    if (value) {
      enterTax.text = '0';
      extraFee.text = '0';
    }
    update();
  }

  void editProduct(
      BuildContext context, String prodId) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'merchant_id': Storage.getValue(Constants.merchantID),
          'api_key': await Constants.apiKey(),
          'name': productName.text.toString(),
          'price': productPrice.text.toString(),
          'description': productDetails.text.toString(),
          'quantity': productQuantity.text.toString(),
          'category_id': productType.toString(),
          'type': productType.toString(),
          'tax': enterTax.text.toString(),
          'shipping_fee': extraFee.text.toString(),
          'asset_ids': selectedImagePaths,
          'meta': {"items_left": productQuantity.text.toString()}
        };
        var response = await DioClient().request(
            context: context,
            api: '/merchant/products/update/$prodId',
            method: Method.FORM,
            payloadObj: request);

        // ProductResponse productResponse = ProductResponse.fromJson(response);
        Map<String, dynamic> respJson = Map<String, dynamic>.from(response);
        final String status = respJson['status'] as String;
        final String message = respJson['message'] as String;

        if (status == Strings.success) {
          Utils.navigationReplace(
              context,
              SuccessfulMgs(
                successTitle: Strings.productUpdated,
                successMessage: Strings.productUpdatedSuccessfully,
              ));
          productsController.fetchProducts(
              context, Storage.getValue(Constants.merchantID));
        } else {
          return Utils.showSnackbar(context, Strings.error,
              message.toString().toTitleCase(), AppColors.red);
        }
      } catch (e) {
        return Utils.showSnackbar(
            context, Strings.error, e.toString(), AppColors.red);
      } finally {
        selectedImagePaths.clear();
        isLoading(false);
      }
      update();
    }
  }

  void fetchProductCategory(BuildContext context) async {
    productTypeList.clear();
    try {
      isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey()
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/products/get-product-categories',
          method: Method.POST,
          params: request);

      ProductCategoryResponse productCategoryResponse =
          ProductCategoryResponse.fromJson(response);
      if (productCategoryResponse.status == Strings.success) {
        productTypeList.addAll(productCategoryResponse.data!);
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

  bool validateInput() {
    if (productName.text.isEmpty) {
      return false;
    } else if (productPrice.text.isEmpty) {
      return false;
    } else if (productQuantity.text.isEmpty) {
      return false;
    } else if (productDetails.text.isEmpty) {
      return false;
    } else if (enterTax.text.isEmpty) {
      return false;
    } else if (extraFee.text.isEmpty) {
      return false;
    } else if (selectedImagePaths.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void createAsset(
      BuildContext context, TinyImage tinyImage, int insertionId) async {
    if (productName.text.isEmpty || productDetails.text.isEmpty) {
      return Utils.showSnackbar(context, Strings.error,
          'Product Name and Detail are required!', AppColors.red);
    } else {
      var uri = Uri.parse("${await Constants.baseUrl()}/merchant/assets/create");
      final mimeTypeData =
          lookupMimeType(tinyImage.picturePath!, headerBytes: [0xFF, 0xD8])!
              .split('/');

      // Intilize the multipart request
      final imageUploadRequest = http.MultipartRequest('POST', uri);
      final file = await http.MultipartFile.fromPath(
          'file', tinyImage.picturePath!,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
      imageUploadRequest.files.add(file);
      imageUploadRequest.fields['merchant_id'] =
          Storage.getValue(Constants.merchantID);
      imageUploadRequest.fields['api_key'] = await Constants.apiKey();
      imageUploadRequest.fields['name'] = productName.text.toString();
      imageUploadRequest.fields['description'] = productDetails.text.toString();

      try {
        final streamedResponse = await imageUploadRequest.send();
        final response = await http.Response.fromStream(streamedResponse);
        var jsonString = response.body;
        AssetsResponse assetsResponse =
            AssetsResponse.fromJson(json.decode(jsonString));
        if (assetsResponse.status == Strings.success) {
          selectedImagePaths.insert(
              insertionId, assetsResponse.data!.id.toString());
          // print('total in the selected is ${selectedImagePaths}');
        } else {
          return Utils.showSnackbar(
              context,
              Strings.error,
              json.decode(jsonString)['message'].toString().toTitleCase(),
              AppColors.red);
        }
      } catch (e) {
        Utils.showSnackbar(context, Strings.error, e.toString(), AppColors.red);
      }
      update();
    }
  }

  void deleteAssets(BuildContext context, String productId, String assetId,
      int insertionId) async {
    try {
      // isLoading(true);
      var request = {
        'merchant_id': Storage.getValue(Constants.merchantID),
        'api_key': await Constants.apiKey()
      };
      var response = await DioClient().request(
          context: context,
          api: '/merchant/products/delete-asset/$productId/$assetId',
          method: Method.POST,
          params: request);

      DeleteResponse deleteResponse = DeleteResponse.fromJson(response);
      if (deleteResponse.status == Strings.success) {
        selectedImagePaths.removeAt(insertionId);
        // print('total is: ' + selectedImagePaths.toString());
        Utils.showSnackbar(context, Strings.success,
            response['message'].toString().toTitleCase(), AppColors.green);
      } else {
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } catch (e) {
      return Utils.showSnackbar(
          context, Strings.error, e.toString(), AppColors.red);
    } finally {
      // isLoading(false);
    }
  }
}
