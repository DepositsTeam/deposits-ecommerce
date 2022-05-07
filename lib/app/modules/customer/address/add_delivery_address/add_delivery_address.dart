import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AddDeliveryAddress extends StatefulWidget {
  AddDeliveryAddress({Key? key,}) : super(key: key);

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  AddDeliveryAddressController controller =
      Get.put(AddDeliveryAddressController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        centerTitle: true,
        addBackButton: true,
        title: Strings.addDeliveryAddress,
        backgroundColor: AppColors.white,
        backbuttonColor: AppColors.black,
        textColor: AppColors.black,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return  GetBuilder<AddDeliveryAddressController>(
                  builder: (controller) =>addAddressBody());
      }),
    );
  }

//--------------------------------------------------------
  Widget addAddressBody() {
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
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //top content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addressNameInput(),
                              streetAddressInput(),
                              zipCodeInput(),
                              verticalSpaceSmall,
                              CountryStateCityPicker(
                                country: controller.country,
                                state: controller.state,
                                city: controller.city,
                                countryValidator: (value) =>
                                    Validators.validateEmpty(value),
                                stateValidator: (value) =>
                                    Validators.validateEmpty(value),
                                cityValidator: (value) =>
                                    Validators.validateEmpty(value),
                              ),
                              verticalSpaceSmall,
                              saveForLater(),
                              makeDefault(),
                            ],
                          ),
                        ),

                        // bottom content
                        Column(
                          children: [addAddressButton(), depositsLogo()],
                        )
                      ],
                    ),
                  )));
        }));
  }

//--------------------------------------------------------
  Widget zipCodeInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.zipCodeController,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.enterZipCode,
        inputFormatters: [
          LengthLimitingTextInputFormatter(5),
              FilteringTextInputFormatter.digitsOnly,
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }
//--------------------------------------------------------
  Widget addressNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.addressName,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.addressName,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }
//--------------------------------------------------------
  Widget streetAddressInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.streetAddressController,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.enterShippingAddress,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
         onTap: () async {
          // generate a new token here
          final sessionToken = const Uuid().v4();
          final Suggestion? result = await showSearch(
            context: context,
            delegate: AddressSearch(sessionToken),
          );
          // This will change the text displayed in the TextField
          if (result != null) {
            final placeDetails = await PlaceApiProvider(sessionToken)
                .getPlaceDetailFromId(result.placeId);
            setState(() {
              controller.streetAddressController.text = '${placeDetails.streetNumber ?? ''} ${placeDetails.street ?? ''}'; //placeDetails.street??
              controller.city.text = '${placeDetails.city!.replaceAll('County', '').replaceAll('Country', '')} ';
              controller.zipCodeController.text = placeDetails.zipCode ?? '';
              controller.state.text = placeDetails.state ?? '';
              controller.country.text = placeDetails.country ?? '';
            });
          }
        },
      ),
    );
  }

//--------------------------------------------------------
  Widget addAddressButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: (){ controller.addDeliveryAddress(context);},
          minWidth: Get.width,
          title: Strings.addAddress,
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

//--------------------------------------------------------
  Widget depositsLogo() {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Offstage(
      offstage: isKeyboardOpen,
      child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: (30)),
          child: CustomSvgimage(image: AppImages.depositsLogo,
            width: 200,
          )),
    );
  }

//--------------------------------------------------------
  Widget makeDefault() {
    return CustomCheckboxWidget(
        value: false,
        titleWidget: const CustomText(
          text: Strings.makeDefaultAddress,
          font: Dimens.fontSize14,
          fntweight: FontWeight.w400,
          txtColor: AppColors.doveGray,
        ));
  }

//--------------------------------------------------------
  Widget saveForLater() {
    return CustomCheckboxWidget(
        value: false,
        titleWidget: const CustomText(
          text: Strings.saveAddressLater,
          font: Dimens.fontSize14,
          fntweight: FontWeight.w400,
          txtColor: AppColors.doveGray,
        ));
  }
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------

}
