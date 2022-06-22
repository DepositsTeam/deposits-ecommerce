import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class EditAddress extends StatefulWidget {
  final ShippingAddressData address;
  EditAddress({Key? key, required this.address})
      : super(key: key);

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  EditAddressController controller = Get.put(EditAddressController());

  @override
  void initState() {
    super.initState();
    controller.addressName.text = widget.address.addressName ?? '';
    controller.streetAddressController.text =
        widget.address.streetAddress ?? '';
    controller.zipCodeController.text = widget.address.zip ?? '';
    controller.country.text = widget.address.country ?? '';
    controller.state.text = widget.address.state ?? '';
    controller.city.text = widget.address.city ?? '';
    controller.streetAddressController.addListener(() {
      if (mounted) setState(() {});
    });
    controller.zipCodeController.addListener(() {
      if (mounted) setState(() {});
    });
    controller.country.addListener(() {
      if (mounted) setState(() {});
    });
    controller.state.addListener(() {
      if (mounted) setState(() {});
    });
    controller.city.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        centerTitle: true,
        addBackButton: true,
        title: Strings.editAddress,
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
        return editAddressBody();
      }),
    );
  }

//--------------------------------------------------------
  Widget editAddressBody() {
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
                          children: [editAddressButton(), depositsLogo()],
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
        textInputAction: TextInputAction.send,
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
        textInputAction: TextInputAction.send,
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
              controller.streetAddressController.text =
                  '${placeDetails.streetNumber ?? ''} ${placeDetails.street ?? ''}'; //placeDetails.street??
              controller.city.text =
                  '${placeDetails.city!.replaceAll('County', '').replaceAll('Country', '')} ';
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
  Widget editAddressButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: Row(
          children: [
            Expanded(
              child: CustomElevatedButton(
                onPressed: () {
                  controller.editAddress(context,
                      widget.address.id.toString());
                },
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
              ),
            ),
            horizontalSpaceSmall,
            horizontalSpaceTiny,
            Expanded(
                child: CustomElevatedButton(
              onPressed: () => controller.deleteAddress(
                  context, widget.address.id.toString()),
              minWidth: Get.width,
              addBorder: true,
              title: Strings.delete,
              textColor: AppColors.borderButtonColor(),
              buttonColor: AppColors.white,
            ))
          ],
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
    return Obx(() => CheckboxListTile(
          value: widget.address.isDefaultAddress == 'true'
              ? true
              : controller.isDefaultAddressSet.value,
          activeColor: AppColors.green,
          checkColor: AppColors.white,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: const CustomText(
            text: Strings.makeDefaultAddress,
            font: Dimens.fontSize14,
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          onChanged: (value) {
            controller.toggleDefaultAddress(value!);
          },
        ));
  }

//--------------------------------------------------------
  Widget saveForLater() {
    return Obx(() => CheckboxListTile(
          value: controller.isSaveForLater.value,
          activeColor: AppColors.green,
          checkColor: AppColors.white,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: const CustomText(
            text: Strings.saveAddressLater,
            font: Dimens.fontSize14,
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          onChanged: (value) {
            controller.toggleIsSaveForLaters(value!);
          },
        ));
  }
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
//--------------------------------------------------------
}
