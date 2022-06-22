import 'package:deposits_ecommerce/app/common/utils/exports.dart';


class EditContactAddress extends StatefulWidget {
   final MerchantData merchantData;
  EditContactAddress({Key? key,required this.merchantData}) : super(key: key);

  @override
  State<EditContactAddress> createState() => _EditContactAddressState();
}

class _EditContactAddressState extends State<EditContactAddress> {
  EditContactAddressController controller = Get.put(EditContactAddressController());

   @override
  void initState() {
    controller.contact.text = widget.merchantData.contactInfo??'';
    controller.address.text = widget.merchantData.contactAddress??'';
    controller.contact.addListener(() {
    if (mounted) setState(() {});
    });
    controller.address.addListener(() {
    if (mounted)setState(() {});
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
          title: Strings.editContactAddress,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return GetBuilder<EditContactAddressController>(
                  builder: (controller) =>editContactAddressContainer());
                     }),
    );
  }
//-------------------------------------------------------
  Widget editContactAddressContainer() {
    return  Form(
        key: controller.formKey,
        child:LayoutBuilder(builder: (context, constraints) {
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
                                contactInput(),
                                addressInput(),
                              ])),
                              // bottom content
                          Column(
                            children: [editConatctAddressButton(),depositsLogo()],
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
  Widget contactInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.contact,
        keyboardType: TextInputType.text,
        addHint: true,
        maxLines: 8,
        minLines: 3,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.contact,
        // inputFormatters: [
        //   FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        // ],
        textInputAction: TextInputAction.next,
      ),
    );
  }
//-------------------------------------------------------
  Widget addressInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.address,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.address,
        // inputFormatters: [
        //   FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        // ],
        textInputAction: TextInputAction.send,
      ),
    );
  }
//-------------------------------------------------------
//-------------------------------------------------------
  Widget editConatctAddressButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: (){ controller.editContactAddress(context,);},
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
}