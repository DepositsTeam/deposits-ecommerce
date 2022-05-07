import 'package:deposits_ecommerce/app/common/utils/exports.dart';
class EditShippingPolicy extends StatefulWidget {
   final MerchantData merchantShipReturnData;
  EditShippingPolicy({Key? key, required this.merchantShipReturnData }) : super(key: key);

  @override
  State<EditShippingPolicy> createState() => _EditShippingPolicyState();
}

class _EditShippingPolicyState extends State<EditShippingPolicy> {
  EditShippingPolicyController controller = Get.put(EditShippingPolicyController());



  @override
  void initState() {
    controller.shippingInfo.text = widget.merchantShipReturnData.shippingPolicy??'null';
    controller.returnPolicyInfo.text = widget.merchantShipReturnData.returnPolicy??'null';
    controller.shippingInfo.addListener(() {
      setState(() {});
    });
    controller.returnPolicyInfo.addListener(() {
     setState(() {});
    });
    super.initState();
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
          title: Strings.editShippingReturnPolicy,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
      body:Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return GetBuilder<EditShippingPolicyController>(
                  builder: (controller) =>editShippingPolicyContainer());
                     }),
    );
  }
//-------------------------------------------------------
  Widget editShippingPolicyContainer() {
    return Form(
        key: controller.formKey,
        child: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: (15)),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                    child:
                        Column(mainAxisSize: MainAxisSize.max, children: [
                          //top content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                shippingInfoInput(),
                                  returnPolicyInput(),
                              ])),
                              // bottom content
                          Column(
                            children: [editShippingButton(),depositsLogo()],
                          )
                        ]))));
      }),
    );
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
Widget shippingInfoInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.shippingInfo,
        keyboardType: TextInputType.text,
        addHint: true,
        maxLines: 8,
        minLines: 3,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.shippingInfo,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }
//-------------------------------------------------------
Widget returnPolicyInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.returnPolicyInfo,
        keyboardType: TextInputType.text,
        addHint: true,
        maxLines: 8,
        minLines: 3,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.returnPolicyInfo,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.send,
      ),
    );
  }
//-------------------------------------------------------
  Widget editShippingButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: (){ controller.editShippingInfo(context);},
          minWidth: Get.width,
          title: Strings.saveChanges,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: controller.validateInput()
                  ? AppColors.black
                  : AppColors.white),
          buttonColor: controller.validateInput()
              ? AppColors.activButtonColor()
              : AppColors.inActivButtonColor(),
        )));
  }
//-------------------------------------------------------
//-------------------------------------------------------
}