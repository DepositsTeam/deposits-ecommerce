import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ProductDetails extends StatefulWidget {
  final ProductData data;
  ProductDetails({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductDetailsController controller = Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.declineColor,
        appBar: CustomAppbarWidget(
          centerTitle: true,
          addBackButton: true,
          backgroundColor: AppColors.declineColor,
          backbuttonColor: AppColors.black,
          textColor: AppColors.black,
          title: Strings.productDetails,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
        body: productDetailsContainer());
  }

//-------------------------------------------------------
  Widget productDetailsContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: (15)),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                  child: Column(
                mainAxisSize: MainAxisSize.max, children: [
                //top content
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      itemImages(),
                      itemStatus(),
                      productDetails()
                    ])),
                // bottom content
                Column(
                  children: [depositsLogo()],
                )
              ]))));
    });
  }

//-------------------------------------------------------
  Widget depositsLogo() {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Offstage(
      offstage: isKeyboardOpen,
      child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: (20)),
          child: CustomSvgimage(image: AppImages.depositsLogo,
            width: 200,
          )),
    );
  }

//------------------------------------------------
  Widget itemImages() {
    return SizedBox(
      height: 200,
      child: widget.data.assets!.isEmpty
          ? Container(
              width: 250,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 18),
              child: PNetworkImage(
                Constants.noAssetImageAvailable,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.data.assets!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) {
                var itemImages = widget.data.assets![i];
                return Container(
                  width: 250,
                  padding: const EdgeInsets.only(right: 18),
                  child: PNetworkImage(
                    itemImages.url!,
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                );
              }),
    );
  }

//------------------------------------------------
  Widget itemStatus() {
    return Row(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: CustomTextTag(
            text: widget.data.status!.toTitleCase(),
            status: widget.data.status,
          ),
        ),
        CustomProductTag(
            text: widget.data.categoryId.toString() + ' goods'.toTitleCase(),
            containerColor: const Color(0xffF5F8FA),
            textColor: AppColors.inActiveTagTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
            status: 'inactive')
      ],
    );
  }

//-------------------------------------------------------
  Widget productDetails() {
    final metaData = jsonDecode(widget.data.meta!);
    var itemsLeft = metaData['items_left'] as String;
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: widget.data.name!,
            font: Dimens.fontSize16,
            fntweight: FontWeight.w400,
          ),
          verticalSpaceSmall,
          verticalSpaceTiny,
          CustomText(
            text: "\$" + widget.data.price!,
            font: Dimens.fontSize32,
            fntweight: FontWeight.w600,
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: (20)),
              child: CustomElevatedButton(
                onPressed: () {
                  controller.editProduct(
                      context, widget.data);
                },
                minWidth: Get.width,
                title: Strings.editProduct,
                textStyle: const TextStyle(
                  color: AppColors.black,
                ),
                buttonColor: AppColors.activButtonColor,
              )),
          const CustomText(
            text: Strings.productId,
            font: Dimens.fontSize18,
            fntweight: FontWeight.w600,
          ),
          verticalSpaceSmall,
          verticalSpaceTiny,
          CustomText(
            text: "#" + widget.data.uuid.toString(),
            font: Dimens.fontSize16,
            fntweight: FontWeight.w400,
          ),
          verticalSpaceMedium,
          const CustomText(
            text: Strings.productDetails,
            font: Dimens.fontSize18,
            fntweight: FontWeight.w600,
          ),
          verticalSpaceSmall,
          verticalSpaceTiny,
          CustomText(
            text: widget.data.description ?? '',
            font: Dimens.fontSize16,
            fntweight: FontWeight.w400,
          ),
          verticalSpaceMedium,
          const CustomText(
            text: Strings.quantityLeft,
            font: Dimens.fontSize18,
            fntweight: FontWeight.w600,
          ),
          verticalSpaceSmall,
          verticalSpaceTiny,
          CustomText(
            text: itemsLeft.toString(),
            font: Dimens.fontSize16,
            fntweight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
}

// To parse this JSON data, do
//
//     final metaResponse = metaResponseFromJson(jsonString);

MetaResponse metaResponseFromJson(String str) =>
    MetaResponse.fromJson(json.decode(str));

String metaResponseToJson(MetaResponse data) => json.encode(data.toJson());

class MetaResponse {
  MetaResponse({
    this.itemsLeft,
  });

  String? itemsLeft;

  factory MetaResponse.fromJson(Map<String, dynamic> json) => MetaResponse(
        itemsLeft: json["items_left"] == null ? null : json["items_left"],
      );

  Map<String, dynamic> toJson() => {
        "items_left": itemsLeft == null ? null : itemsLeft,
      };
}
