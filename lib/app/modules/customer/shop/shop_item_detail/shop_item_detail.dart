import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ShopItemDetail extends StatefulWidget {
  final ProductData data;
  final DepositsEcommerceContext? shopContext;
  const ShopItemDetail(
      {Key? key,
      required this.data,
      this.shopContext,})
      : super(key: key);

  @override
  State<ShopItemDetail> createState() => _ShopItemDetailState();
}

class _ShopItemDetailState extends State<ShopItemDetail>
    with WidgetsBindingObserver {
       ShopItemDetailController get controller {
    return Get.put(ShopItemDetailController(shopContext: widget.shopContext));
  }
  // ShopItemDetailController controller = Get.put(ShopItemDetailController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchAddress(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchAddress(context);
    }
  }

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
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return GetBuilder<ShopItemDetailController>(
            builder: (controller) => shopItemConatiner());
      }),
    );
  }

//------------------------------------------------
  Widget shopItemConatiner() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                  child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        itemImages(),
                        itemStatus(),
                        itemDetails(),
                        controller.addresses.isEmpty
                            ? enterAddressDetails()
                            : const SizedBox(),
                        controller.addresses.isNotEmpty
                            ? selectPreviousAddress()
                            : const SizedBox(),
                        shippingInfo(),
                        checkOutButton(),
                      ])),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [bottomContent()]),
                ],
              ))));
    });
  }

//------------------------------------------------
  Widget itemImages() {
    return SizedBox(
      height: 200,
      child: widget.data.assets!.isEmpty
          ? Container(
              width: 250,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: 18),
              child: PNetworkImage(
                Constants.noAssetImageAvailable,
                width: Get.width,
                fit: BoxFit.cover,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: widget.data.assets!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, i) {
                var itemImages = widget.data.assets![i];
                return Container(
                  width: 250,
                  padding: const EdgeInsets.only(right: 18),
                  child: PNetworkImage(
                    itemImages.url!,
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                );
              }),
    );
  }

//------------------------------------------------
  Widget itemStatus() {
    return Container(
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(vertical: 18),
      child: CustomTextTag(
        text: widget.data.status,
        status: widget.data.status,
      ),
    );
  }

//------------------------------------------------
  Widget itemDetails() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: widget.data.name!,
            font: Dimens.fontSize16,
            txtAlign: TextAlign.start,
            fntweight: FontWeight.w400,
          ),
          verticalSpaceSmall,
          verticalSpaceTiny,
          CustomText(
            text: "\$" + widget.data.price!,
            font: Dimens.fontSize26,
            fntweight: FontWeight.w700,
          ),
          verticalSpaceMedium,
          const CustomText(
            text: Strings.productDetails,
            font: Dimens.fontSize18,
            fntweight: FontWeight.w700,
          ),
          verticalSpaceSmall,
          verticalSpaceTiny,
          CustomText(
            text: widget.data.description!,
            font: Dimens.fontSize16,
            fntweight: FontWeight.w400,
          ),
          verticalSpaceSmall,
          verticalSpaceMedium,
          const CustomText(
            text: Strings.deliveryAddress,
            font: Dimens.fontSize18,
            fntweight: FontWeight.w700,
          ),
          verticalSpaceSmall,
          verticalSpaceTiny,
        ],
      ),
    );
  }

//------------------------------------------------
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

//------------------------------------------------
  Widget enterAddressDetails() {
    return Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: Strings.enterShippingAddress,
              font: Dimens.fontSize16,
              fntweight: FontWeight.w400,
            ),
            verticalSpaceMedium,
            addressNameInput(),
            streetAddressInput(),
            zipCodeInput(),
            verticalSpaceSmall,
            CountryStateCityPicker(
              country: controller.country,
              state: controller.state,
              city: controller.city,
              countryValidator: (value) => Validators.validateEmpty(value),
              stateValidator: (value) => Validators.validateEmpty(value),
              cityValidator: (value) => Validators.validateEmpty(value),
            ),
            checkDefault(),
          ],
        ));
  }

//------------------------------------------------
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
//------------------------------------------------

//------------------------------------------------
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
              controller.city.text = placeDetails.city ?? '';
              controller.zipCodeController.text = placeDetails.zipCode ?? '';
              controller.state.text = placeDetails.state ?? '';
              controller.country.text = placeDetails.country ?? '';
            });
          }
        },
      ),
    );
  }

//------------------------------------------------
  Widget checkOutButton() {
    var subTotal = widget.data.price == null || (widget.data.price != null && widget.data.price!.isEmpty)
        ? 0.00
        : double.parse(widget.data.price!.replaceAll(',', ''));
    var taxFees = widget.data.shippingFee == null || (widget.data.shippingFee != null && widget.data.shippingFee!.isEmpty)
        ? 0.00
        : double.parse(widget.data.shippingFee.replaceAll(',', ''));
    var total = subTotal + taxFees;
     
    double totalCharge = total;
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () {
            controller.clickToShopItem(context, totalCharge, widget.data,);
          },
          minWidth: Get.width,
          title: Strings.checkout,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: (controller.validateInput() ||
                      controller.addresses.isNotEmpty)
                  ? AppColors.black
                  : AppColors.white),
          buttonColor:
              (controller.validateInput() || controller.addresses.isNotEmpty)
                  ? AppColors.activButtonColor
                  : AppColors.inActivButtonColor,
        )));
  }

//------------------------------------------------
  Widget checkDefault() {
    return CustomCheckboxWidget(
        value: false,
        titleWidget: const CustomText(
          text: 'Save this address for later',
          font: Dimens.fontSize14,
          fntweight: FontWeight.w400,
          txtColor: AppColors.doveGray,
        ));
  }

//------------------------------------------------
  Widget bottomContent() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(
        bottom: 25,
      ),
      child: CustomSvgimage(image: AppImages.depositsLogo,
      width: 200,),
    );
  }

//------------------------------------------------
  Widget shippingInfo() {
   
    var subTotal = widget.data.price == null || (widget.data.price != null && widget.data.price!.isEmpty)
        ? 0.00
        : double.parse(widget.data.price!.replaceAll(',', ''));


    var taxFees = widget.data.shippingFee == null || (widget.data.shippingFee != null && widget.data.shippingFee!.isEmpty)
        ? 0.00
        : double.parse(widget.data.shippingFee.replaceAll(',', ''));
    var total = subTotal + taxFees;
    double totalCharge = total;
    return Container(
        margin: const EdgeInsets.only(top: (20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRowTextWidget(
              title: Strings.subTotal,
              titleStyle: const TextStyle(color: Color(0xff5F6B7A)),
              titleOnTap: () {},
              subtitle: widget.data.price == null
                  ? "\$0.00"
                  : "\$" + subTotal.toStringAsFixed(2),
              subtitleStyle: const TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w600),
            ),
            verticalSpaceTiny,
            CustomRowTextWidget(
              title: Strings.taxFees,
              titleStyle: const TextStyle(color: Color(0xff5F6B7A)),
              titleOnTap: () {},
              subtitle: widget.data.shippingFee == null
                  ? "\$0.00"
                  : "\$" + taxFees.toStringAsFixed(2),
              subtitleStyle: const TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w600),
            ),
            verticalSpaceTiny,
            CustomRowTextWidget(
              title: Strings.toatl,
              titleStyle: const TextStyle(color: Color(0xff5F6B7A)),
              titleOnTap: () {},
              subtitle: "\$" + totalCharge.toStringAsFixed(2),
              subtitleStyle: const TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w600),
            ),
          ],
        ));
  }

//------------------------------------------------
  Widget selectPreviousAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CustomText(
          text: Strings.selectShippingAddress,
          font: Dimens.fontSize16,
          txtAlign: TextAlign.start,
          fntweight: FontWeight.w400,
        ),
        verticalSpaceMedium,
        currentAddressSelected(),
      ],
    );
  }

//------------------------------------------------
  Widget currentAddressSelected() {
    var addresss = controller.addresses
        .firstWhere((element) => element.isDefaultAddress == 'true');
    return CustomListTileWidget(
      title: addresss.streetAddress ?? '',
      leading: CustomSvgimage(image: AppImages.location),
      onTap: () {
        Utils.navigationPush(
            context,
            DeliveryAddress());
      },
      trailing: const Icon(Icons.arrow_forward_ios_sharp),
      subTitle:
          addresss.city! + ' ' + addresss.state! + ' (' + addresss.zip! + ') ',
    );
  }

//------------------------------------------------
//------------------------------------------------
//------------------------------------------------

//------------------------------------------------
}
