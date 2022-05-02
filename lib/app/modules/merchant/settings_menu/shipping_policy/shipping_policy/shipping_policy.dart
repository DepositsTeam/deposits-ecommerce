import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ShippingPolicy extends StatefulWidget {
  ShippingPolicy({Key? key,}) : super(key: key);

  @override
  State<ShippingPolicy> createState() => _ShippingPolicyState();
}

class _ShippingPolicyState extends State<ShippingPolicy>with WidgetsBindingObserver {
  ShippingPolicyController controller = Get.put(ShippingPolicyController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchShippingRetunPolicy(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchShippingRetunPolicy(context);
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
          title: Strings.shippingReturnPolicy,
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
        return CustomNoInternetRetry(message: controller.errorMessage.value, onPressed: () { controller.fetchShippingRetunPolicy(context); }, title: Strings.error,);
      }
        return shippingPolicyContainer();
        }),
    );
  }
//-------------------------------------------------------
  Widget shippingPolicyContainer() {
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
                            children: [
                              shippingPolicyContent()
                            ])),
                            // bottom content
                        Column(
                          children: [
                            editShippingPolicyButton(),
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
          child: CustomSvgimage(image: AppImages.depositsLogo)),
    );
  }
//-------------------------------------------------------
 Widget editShippingPolicyButton() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
              onPressed: () => controller.editShippingPolicy(context),
              minWidth: Get.width,
              addBorder: true,
              title: Strings.editShippingReturnPolicy,
              textColor: AppColors.borderButtonColor,
              buttonColor: AppColors.declineColor,
              loaderColor: AppColors.borderButtonColor,
            ),
    );
  }
//-------------------------------------------------------
  Widget shippingPolicyContent(){
  return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      verticalSpaceSmall,
      verticalSpaceTiny,
      const CustomText(
          text: Strings.shippingInfo,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantShipReturnData.value.shippingPolicy??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
         verticalSpaceSmall,
      verticalSpaceTiny,
     const CustomText(
          text: Strings.returnPolicyInfo,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
       CustomText(
          text: controller.merchantShipReturnData.value.returnPolicy??'null',
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