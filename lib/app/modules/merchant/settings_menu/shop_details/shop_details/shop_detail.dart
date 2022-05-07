import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ShopDetail extends StatefulWidget {
  ShopDetail({Key? key}) : super(key: key);

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail>with WidgetsBindingObserver {
  ShopDetailController controller = Get.put(ShopDetailController());

   @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchShopDetails(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchShopDetails(context);
    }
}

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
          title: Strings.shopDetails,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
      body:Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        if (controller.isError.value) {
        return CustomNoInternetRetry(message: controller.errorMessage.value, onPressed: () { controller.fetchShopDetails(context); }, title: Strings.error,);
      }
        return shopDetailContainer();
        }),
    );
  }
//-------------------------------------------------------
  Widget shopDetailContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: (15)),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                  child:
                      Column(mainAxisSize: MainAxisSize.max,
                       crossAxisAlignment: CrossAxisAlignment.start, children: [
                        //top content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [shopDetailContent()])),
                            // bottom content
                        Column(
                          children: [
                            editShopDetailButton(),
                            depositsLogo()],
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
          child: CustomSvgimage(image: AppImages.depositsLogo, width: 200,
          )),
    );
  }
//-------------------------------------------------------
  Widget editShopDetailButton() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
              onPressed: () => controller.editShopDetail(context),
              minWidth: Get.width,
              addBorder: true,
              title: Strings.editShopDetails,
              textColor: AppColors.borderButtonColor(),
              buttonColor: AppColors.declineColor,
              loaderColor: AppColors.borderButtonColor(),
            ),
    );
  }
//-------------------------------------------------------
  Widget shopDetailContent(){
  return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.shopName,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.name??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
        verticalSpaceSmall,
        verticalSpaceTiny,
        const CustomText(
          text: Strings.shopDescirption,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
        CustomText(
          text: controller.merchantData.value.description ?? 'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
         verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.shopCategory,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.category??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
        verticalSpaceSmall,
      verticalSpaceTiny,
    const  CustomText(
          text: Strings.zipCode,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.zip??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
        verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.streetAddress,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.streetAddress??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
        verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.city,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.city??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
        verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.state,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.state??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
        verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.country,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.country??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
    ],
  );
}
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
}