import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ContactAddress extends StatefulWidget {

  ContactAddress({Key? key,  }) : super(key: key);

  @override
  State<ContactAddress> createState() => _ContactAddressState();
}

class _ContactAddressState extends State<ContactAddress>with WidgetsBindingObserver {
  ContactAddressController controller = Get.put(ContactAddressController());

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
          title: Strings.contactAddress,
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
        return contactAddressContainer();
        }),
        );
  }

//-------------------------------------------------------
  Widget contactAddressContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: (15)),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    //top content
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [contactAddressContent()])),
                    // bottom content
                    Column(
                      children: [editContactAddressButton(), depositsLogo()],
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
  Widget editContactAddressButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (20)),
      child: CustomElevatedButton(
        onPressed: () =>
            controller.editContactAddress(context, ),
        minWidth: Get.width,
        addBorder: true,
        title: Strings.editContactAddress,
        textColor: AppColors.borderButtonColor,
        buttonColor: AppColors.declineColor,
        loaderColor: AppColors.borderButtonColor,
      ),
    );
  }

//-------------------------------------------------------
  Widget contactAddressContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        verticalSpaceSmall,
        verticalSpaceTiny,
      const  CustomText(
          text: Strings.contact,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
        CustomText(
          text: controller.merchantData.value.contactInfo??'null',
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
        ),
        verticalSpaceSmall,
        verticalSpaceTiny,
      const  CustomText(
          text: Strings.address,
          font: Dimens.fontSize16,
          fntweight: FontWeight.w300,
        ),
        verticalSpaceTiny,
        CustomText(
          text: controller.merchantData.value.contactAddress??'null',
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
