import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import '../../../../../model/common/merchant.dart';

class EditTaxFee extends StatefulWidget {
   final MerchantData merchantData;
  EditTaxFee({Key? key,required this.merchantData }) : super(key: key);

  @override
  State<EditTaxFee> createState() => _EditTaxFeeState();
}

class _EditTaxFeeState extends State<EditTaxFee> {
  EditTaxFeeController controller = Get.put(EditTaxFeeController());

  @override
  void initState() {
    controller.taxId.text = widget.merchantData.taxId ?? '';
    controller.taxPercentage.text = widget.merchantData.taxPercent ??'';
    controller.extraFee.text =widget.merchantData.shippingFee ?? '';
    controller.taxId.addListener(() {
       if (mounted) setState(() {});
    });
    controller.taxPercentage.addListener(() {
      if (mounted) setState(() {});
    });
    controller.extraFee.addListener(() {
      if (mounted) setState(() {});
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
          title: Strings.editTaxFee,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
      body:Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return  GetBuilder<EditTaxFeeController>(
                  builder: (controller) =>editTaxFeeContainer());
                     }),
    );
  }
//-------------------------------------------------------
  Widget editTaxFeeContainer() {
    return  Form(
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
                                taxIdInput(),
                                taxPercentageInput(),
                                extraFeeInput(),
                              ])),
                              // bottom content
                          Column(
                            children: [editTaxFeeButton(),depositsLogo()],
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
 Widget editTaxFeeButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: (){ controller.editTaxFee(context);},
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
 Widget taxIdInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.taxId,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.enterTaxId,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }
//-------------------------------------------------------
  Widget taxPercentageInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.taxPercentage,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.enterTaxPerc,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }
//-------------------------------------------------------
  Widget extraFeeInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.extraFee,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.extraFee,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.send,
      ),
    );
  }
//-------------------------------------------------------
}