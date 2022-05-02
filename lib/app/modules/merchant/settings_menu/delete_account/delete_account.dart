import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class DeleteAccount extends StatefulWidget {
  DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  DeleteAccountController controller = Get.put(DeleteAccountController());

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
        title: Strings.deleteAccount,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return GetBuilder<DeleteAccountController>(
            builder: (controller) => deleteAccountContainer());
      }),
    );
  }

//-------------------------------------------------------
  Widget deleteAccountContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: (15)),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                //top content
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                      verticalSpaceMassive,
                      CustomSvgimage(
                        image: AppImages.deleteAccount,
                      ),
                      verticalSpaceMedium,
                      CustomText(text: Strings.dell)
                    ])),
                // bottom content
                Column(
                  children: [checkDelete(), deleteButton(), depositsLogo()],
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
  Widget deleteButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () {
            controller.deletShop(context,);
          },
          minWidth: Get.width,
          title: Strings.deleteAccount,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: controller.isDeleteShop.isTrue
                  ? AppColors.black
                  : AppColors.white),
          buttonColor: controller.isDeleteShop.isTrue
              ? AppColors.activButtonColor
              : AppColors.inActivButtonColor,
        )));
  }

//-------------------------------------------------------
  Widget checkDelete() {
    return CheckboxListTile(
      value: controller.isDeleteShop.value,
      activeColor: AppColors.green,
      checkColor: AppColors.white,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: const CustomText(
        text: 'I agree to delete my shop account',
        font: Dimens.fontSize14,
        fntweight: FontWeight.w400,
        txtColor: AppColors.doveGray,
      ),
      onChanged: (value) {
        controller.toggleDefaultAddress(value!);
      },
    );
  }
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
}
