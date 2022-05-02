import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class TaxFee extends StatefulWidget {
  TaxFee({Key? key}) : super(key: key);

  @override
  State<TaxFee> createState() => _TaxFeeState();
}

class _TaxFeeState extends State<TaxFee> with WidgetsBindingObserver {
  TaxFeeController controller = Get.put(TaxFeeController());

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
          title: Strings.taxFees,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        if (controller.isError.value) {
        return CustomNoInternetRetry(message: controller.errorMessage.value, onPressed: () { controller.fetchShopDetails(context); }, title: Strings.error,);
      }
        return taxFeeContainer();
        })
    );
  }
//-------------------------------------------------------
  Widget taxFeeContainer() {
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
                            children: [taxContent()])),
                            // bottom content
                        Column(
                          children: [editTaxFeeButton(),depositsLogo()],
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
//-------------------------------------------------------
 Widget editTaxFeeButton() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
              onPressed: () => controller.editTaxFee(context),
              minWidth: Get.width,
              addBorder: true,
              title: Strings.editTaxFee,
              textColor: AppColors.borderButtonColor,
              buttonColor: AppColors.declineColor,
              loaderColor: AppColors.borderButtonColor,
            ),
    );
  }
//-------------------------------------------------------
  Widget taxContent(){
  return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.taxID,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.taxId??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
         verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.taxPerc,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text:controller.merchantData.value.taxPercent==null?'null' :controller.merchantData.value.taxPercent +' %',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
        verticalSpaceSmall,
      verticalSpaceTiny,
    const  CustomText(
          text: Strings.extraEarn,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w400,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantData.value.shippingFee==null ? 'null':  '\$'+controller.merchantData.value.shippingFee,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w700,
        ),
    ],
  );
}
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
}