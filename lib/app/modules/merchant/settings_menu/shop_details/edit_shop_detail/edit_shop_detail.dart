import 'package:deposits_ecommerce/app/common/utils/exports.dart';


class EditShopDetail extends StatefulWidget {
  
  final MerchantData merchantData;
  EditShopDetail({Key? key, required this.merchantData})
      : super(key: key);

  @override
  State<EditShopDetail> createState() => _EditShopDetailState();
}

class _EditShopDetailState extends State<EditShopDetail> {
  EditShopDetailController controller = Get.put(EditShopDetailController());

  @override
  void initState() {
    controller.storeName.text = widget.merchantData.name ?? '';
    controller.streetAddressController.text =
        widget.merchantData.streetAddress ?? '';
    controller.zipCodeController.text = widget.merchantData.zip ?? '';
    controller.country.text = widget.merchantData.country ?? '';
    controller.state.text = widget.merchantData.state ?? '';
    controller.city.text = widget.merchantData.city ?? '';
    controller.fetchStoreCategory(context);
    controller.storeName.addListener(() {
      setState(() {});
    });
    controller.streetAddressController.addListener(() {
      setState(() {});
    });
    controller.zipCodeController.addListener(() {
      setState(() {});
    });
    controller.country.addListener(() {
      setState(() {});
    });
    controller.state.addListener(() {
      setState(() {});
    });
    controller.city.addListener(() {
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
        title: Strings.editShopDetails,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return GetBuilder<EditShopDetailController>(
            builder: (controller) => shopDetailContainer());
      }),
    );
  }

//-------------------------------------------------------
  Widget shopDetailContainer() {
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
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                  //top content
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        storeNameInput(),
                        storeDescriptionInput(),
                        storeCategory(),
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
                      ])),
                  // bottom content
                  Column(
                    children: [editShopDetailButton(), depositsLogo()],
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
Widget storeDescriptionInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.storeDescription,
        keyboardType: TextInputType.text,
        addHint: true,
        maxLines: 8,
        minLines: 3,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.storeDesc,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }
//-------------------------------------------------------
  Widget editShopDetailButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () {
            controller.editShopDetails(context);
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
        )));
  }

//-------------------------------------------------------
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

//-------------------------------------------------------
  Widget storeCategory() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: DropdownWidget(
          currentItem: widget.merchantData.category??controller.storeCategoryList.first,
          items: controller.storeCategoryList,
          title: Strings.storeCategory,
          itemCallBack: (value) => setState(() {
            controller.storeCategory = value;
            widget.merchantData.category = value;
          }),
          validator: (value) => value == null ? Strings.fieldCantBeEmpty : null,
        )
        );
  }

//-------------------------------------------------------
  Widget streetAddressInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.streetAddressController,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.streetAddress,
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

//-------------------------------------------------------
  Widget storeNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.storeName,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.storeName,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }
//-------------------------------------------------------
}
