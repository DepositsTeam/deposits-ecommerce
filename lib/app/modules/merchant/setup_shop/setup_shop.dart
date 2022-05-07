import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class SetUpShop extends StatelessWidget {
  final DepositsEcommerceContext? shopContext;

  const SetUpShop({Key? key, this.shopContext})
      : super(key: key);

  SetUpShopController get controller {
    return Get.put(SetUpShopController(shopContext: shopContext!));
  }
  // SetUpShopController controller = Get.put(SetUpShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: CustomAppbarWidget(
          centerTitle: true,
          addBackButton: true,
          backgroundColor: AppColors.white,
          backbuttonColor: AppColors.black,
          textColor: AppColors.black,
          title: Strings.setUpShop,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
        body: GetBuilder<SetUpShopController>(
            init: controller,
            builder: (controller) {
              if (controller.isLoading.value) {
                return Utils.loader();
              }
              return controller.isDepositsIdDerived.isFalse
                  ? derivedDepositsInfo(context)
                  : setUpContainer(context);
            }));
  }

//-------------------------------------------------------
  Widget derivedDepositsInfo(BuildContext context) {
    return Form(
        key: controller.formKey2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [depositsEmailInput(), confirmEmailButton(context)],
            ),
          ),
        ));
  }

//-------------------------------------------------------
  Widget setUpContainer(BuildContext context) {
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
                      Expanded(
                        child: //top content
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              shopDesc(),
                              storeNameInput(),
                              storeDescriptionInput(),
                              storeCategory(context),
                              streetAddressInput(context),
                              zipCodeInput(),
                              countryStateCity(),
                            ]),
                      ),
                      // bottom content
                      Column(
                        children: [
                          setUpShopButton(context),
                          depositsLogo(context)
                        ],
                      )
                    ]),
                  )));
        }));
  }

  Widget shopDesc() {
    return Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: (18)),
        child: const CustomText(
          text: "Create your online store!",
          txtColor: AppColors.mineShaft,
          font: Dimens.fontSize14,
          fntweight: FontWeight.w400,
          txtAlign: TextAlign.center,
        ));
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
  Widget storeNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.storeName,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.storeName,
        textInputAction: TextInputAction.next,
      ),
    );
  }
//----------------------------------------------------
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
  Widget depositsEmailInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.email,
        keyboardType: TextInputType.emailAddress,
        addHint: true,
        validator: (value) => Validators.validateEmail(value),
        hintText: Strings.emailAddress,
        textInputAction: TextInputAction.done,
      ),
    );
  }

//-------------------------------------------------------
  Widget streetAddressInput(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.streetAddressController,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.enterStreetAddress,
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
            controller.streetAddressController.text =
                '${placeDetails.streetNumber ?? ''} ${placeDetails.street ?? ''}'; //placeDetails.street??
            controller.city.text = placeDetails.city ?? '';
            controller.zipCodeController.text = placeDetails.zipCode ?? '';
            controller.state.text = placeDetails.state ?? '';
            controller.country.text = placeDetails.country ?? '';

            controller.update();
          }
        },
      ),
    );
  }

//-------------------------------------------------------
  Widget countryStateCity() {
    return Column(
      children: [
        verticalSpaceSmall,
        CountryStateCityPicker(
          country: controller.country,
          state: controller.state,
          city: controller.city,
          countryValidator: (value) => Validators.validateEmpty(value),
          stateValidator: (value) => Validators.validateEmpty(value),
          cityValidator: (value) => Validators.validateEmpty(value),
        ),
      ],
    );
  }

//-------------------------------------------------------
  Widget setUpShopButton(BuildContext context) {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () => controller.setUpShop(context),
          minWidth: Get.width,
          title: Strings.cont,
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
  Widget confirmEmailButton(BuildContext context) {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () => controller.getDepositsEmail(context),
          minWidth: Get.width,
          title: Strings.cont,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: controller.validateEmail()
                  ? AppColors.black
                  : AppColors.white),
          buttonColor: controller.validateEmail()
              ? AppColors.activButtonColor()
              : AppColors.inActivButtonColor(),
        )));
  }

//-------------------------------------------------------
  Widget depositsLogo(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Offstage(
      offstage: isKeyboardOpen,
      child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: (30)),
          child: CustomSvgimage(
            image: AppImages.depositsLogo,
            width: 200,
          )),
    );
  }

//-------------------------------------------------------
  Widget storeCategory(BuildContext context) {
    return Obx(() {
      if (controller.storeCategoryList.isEmpty) {
        controller.fetchStoreCategory(context);
        return Utils.loader();
      } else {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: (10)),
            child: DropdownWidget(
              currentItem: controller.storeCategory.value,
              items: controller.storeCategoryList,
              title: Strings.storeCategory,
              itemCallBack: (value) {
                controller.storeCategory.value = value;
              },
              validator: (value) =>
                  value == null ? Strings.fieldCantBeEmpty : null,
            ));
      }
    });
  }
//-------------------------------------------------------
//-------------------------------------------------------
}
