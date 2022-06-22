import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class Shops extends StatelessWidget {
  final String? customerId;
  final DepositsEcommerceContext? shopContext;

  const Shops({Key? key, this.customerId, this.shopContext}) : super(key: key);

  ShopsController get controller {
    return Get.put(ShopsController(shopContext: shopContext));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopsController>(
        init: controller,
        global: false,
        initState: (state) async {
          await controller.loadContent(context);
        },
        builder: (controller) {
          return Scaffold(
              backgroundColor: AppColors.white,
              appBar: CustomAppbarWidget(
                centerTitle: true,
                addBackButton: true,
                backgroundColor: AppColors.white,
                backbuttonColor: AppColors.black,
                textColor: AppColors.black,
                title: controller.merchantData.value.name,
                textSize: (Dimens.fontSize16),
                onBackPress: () {
                  Navigator.pop(context);
                },
                actions: [
                  // Padding(
                  //     padding: const EdgeInsets.only(right: 16.0),
                  //     child: CustomInkwellWidget(
                  //         onTap: () {
                  //           filterItem(context);
                  //         },
                  //         child: CustomSvgimage(image: AppImages.filter))),
                  Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CustomInkwellWidget(
                          onTap: () {
                            controller.hideShowSearch();
                          },
                          child: CustomSvgimage(image: AppImages.search))),
                ],
              ),
              body: Obx( () {
                  if (controller.isLoading.value) {
                    return Utils.loader();
                  }
                  if (controller.isError.value) {
                    return CustomNoInternetRetry(
                      message: controller.errorMessage.value,
                      onPressed: () async {
                        await controller.loadContent(context);
                      },
                      title: Strings.error,
                    );
                  }
                  return shopsContainer(context);
                },
              )
              );
        });
  }

//----------------------------------------------------
  Widget shopsContainer(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.fontSize20),
        child: Column(
          children: [
            controller.isSearchItemVisible.isFalse
                ? shopDesc(context)
                : searchContainer(),
            allShopItems(context),
            //TODO moe it inside the page
            depositsLogo(),
          ],
        ));
  }

//----------------------------------------------------
  Widget shopDesc(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: (18)),
      child: CustomRichTextWidget(
        title1: controller.merchantData.value.description,
        title2: Strings.shipping,
        onSubtitleTap2: () => shippingOnClick(context),
        title3: Strings.and,
        title4: Strings.returnPolicySmall,
        onSubtitleTap4: () => returnPolicyOnClick(context),
        title5: Strings.pageOr,
        title6: Strings.contactus,
        onSubtitleTap6: () => contactUsOnClick(context),
        title7: Strings.moreInfo,
      ),
    );
  }

//----------------------------------------------------
  Widget searchContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: (9)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 10,
                child: CustomTextFieldWidget(
                  controller: controller.searchController,
                  keyboardType: TextInputType.text,
                  addHint: true,
                  validator: null,
                  hintText: 'Search products',
                  onChanged: (value) => controller.filterSearchResults(value!),
                  textInputAction: TextInputAction.search,
                ),
              ),
              Expanded(
                  flex: 2,
                  child: CustomInkwellWidget(
                      onTap: () {
                        controller.hideShowSearch();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 35,
                        color: AppColors.borderColor,
                      )))
            ],
          ),
          verticalSpaceMedium,
          CustomText(
            text: controller.totalResults.toString() + " search Results",
            txtColor: AppColors.doveGray,
            font: Dimens.fontSize18,
            txtAlign: TextAlign.start,
            fntstyle: FontStyle.normal,
            fntweight: FontWeight.w400,
          ),
        ],
      ),
    );
  }

//----------------------------------------------------
  Widget allShopItems(BuildContext context) {
    return Expanded(
      flex: 1,
      child: controller.items.isEmpty
          ? Container(
              child: const Center(
                child: CustomText(text: 'No search results found'),
              ),
            )
          : GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 6.0,
                  crossAxisSpacing: 12.0,
                  childAspectRatio: .5,
                  crossAxisCount: 2),
              itemCount: controller.items.length,
              itemBuilder: (_, i) {
                var item = controller.items[i];
                return InkWell(
                  onTap: () {
                    Utils.navigationPush(
                        context,
                        ShopItemDetail(
                          data: item,
                          shopContext: shopContext,
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            child: PNetworkImage(
                              item.assets!.isNotEmpty
                                  ? item.assets![0].url!
                                  : Constants.noAssetImageAvailable,
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                        verticalSpaceSmall,
                        CustomTextTag(
                          text: item.status!.toTitleCase(),
                          height: 27,
                          width: 100,
                          status: item.status,
                        ),
                        verticalSpaceSmall,
                        CustomText(
                          text: item.name! + " " + item.description!,
                          font: Dimens.fontSize16,
                          fntweight: FontWeight.w300,
                          maxLine: 1,
                          ellipsis: TextOverflow.ellipsis,
                        ),
                        verticalSpaceSmall,
                        CustomText(
                          text: "\$" + item.price!,
                          font: Dimens.fontSize18,
                          fntweight: FontWeight.w600,
                          ellipsis: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }

//----------------------------------------------------
  void filterItem(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 4,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        enableDrag: true,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Form(
                key: controller.formKey,
                // autovalidate: controller.autovalidate.value,
                child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 15, bottom: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            const CustomText(
                              text: Strings.filterBy,
                              font: Dimens.fontSize16,
                              fntweight: FontWeight.w700,
                            ),
                            CustomInkwellWidget(
                                onTap: () {
                                  Navigator.pop(context);
                                  // controller.autovalidate(false);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.borderColor,
                                ))
                          ],
                        ),
                        verticalSpaceMedium,
                        DropdownWidget(
                          currentItem: controller.availability,
                          items: controller.availabilityList,
                          title: Strings.itemAvailability,
                          itemCallBack: (value) => setState(() {
                            controller.availability = value;
                          }),
                          validator: (value) =>
                              value == null ? Strings.fieldCantBeEmpty : null,
                        ),
                        verticalSpaceSmall,
                        DropdownWidget(
                          currentItem: controller.price,
                          items: controller.priceList,
                          title: Strings.storeCategory,
                          itemCallBack: (value) => setState(() {
                            controller.price = value;
                          }),
                          validator: (value) =>
                              value == null ? Strings.fieldCantBeEmpty : null,
                        ),
                        verticalSpaceSmall,
                        verticalSpaceSmall,
                        Obx(() => Container(
                            margin: const EdgeInsets.symmetric(vertical: (20)),
                            child: CustomElevatedButton(
                              onPressed: () => controller.filterShopItems(
                                  context, controller.availability),
                              minWidth: Get.width,
                              title: Strings.filter,
                              isBusy: controller.isLoading.value,
                              textStyle: const TextStyle(color: AppColors.black),
                              buttonColor: AppColors.activButtonColor(),
                            )))
                      ],
                    )));
          });
        });
    // .whenComplete(() => controller.autovalidate(true));
  }

//----------------------------------------------------
  Widget depositsLogo() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomSvgimage(
          image: AppImages.depositsLogo,
          width: 200,
        ));
  }

//----------------------------------------------------
  void shippingOnClick(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 4,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        enableDrag: true,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 15, bottom: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        const CustomText(
                          text: Strings.shipping,
                          font: Dimens.fontSize16,
                          fntweight: FontWeight.w700,
                        ),
                        CustomInkwellWidget(
                            onTap: () {
                              Navigator.pop(context);
                              // controller.autovalidate(false);
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.borderColor,
                            ))
                      ],
                    ),
                    verticalSpaceMedium,
                    CustomText(
                      text: controller.merchantData.value.shippingPolicy ?? '',
                      font: Dimens.fontSize16,
                      txtAlign: TextAlign.start,
                      fntweight: FontWeight.w300,
                    ),
                    verticalSpaceMedium,
                  ]));
        });
  }

//----------------------------------------------------
  void returnPolicyOnClick(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 4,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        enableDrag: true,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 15, bottom: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        const CustomText(
                          text: Strings.returnPolicy,
                          font: Dimens.fontSize16,
                          fntweight: FontWeight.w700,
                        ),
                        CustomInkwellWidget(
                            onTap: () {
                              Navigator.pop(context);
                              // controller.autovalidate(false);
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.borderColor,
                            ))
                      ],
                    ),
                    verticalSpaceMedium,
                    CustomText(
                      text: controller.merchantData.value.returnPolicy ?? '',
                      font: Dimens.fontSize16,
                      txtAlign: TextAlign.start,
                      fntweight: FontWeight.w300,
                    ),
                    verticalSpaceMedium,
                  ]));
        });
  }

//----------------------------------------------------
  void contactUsOnClick(BuildContext context) {
    showModalBottomSheet(
        context: context,
        elevation: 4,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        enableDrag: true,
        builder: (context) {
          return Container(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, top: 15, bottom: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        const CustomText(
                          text: Strings.contactAddress,
                          font: Dimens.fontSize16,
                          fntweight: FontWeight.w700,
                        ),
                        CustomInkwellWidget(
                            onTap: () {
                              Navigator.pop(context);
                              // controller.autovalidate(false);
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.borderColor,
                            ))
                      ],
                    ),
                    verticalSpaceMedium,
                    CustomText(
                      text: controller.merchantData.value.contactInfo ?? '',
                      font: Dimens.fontSize16,
                      txtAlign: TextAlign.start,
                      fntweight: FontWeight.w300,
                    ),
                    verticalSpaceSmall,
                    CustomText(
                      text: controller.merchantData.value.contactAddress ?? '',
                      font: Dimens.fontSize16,
                      fntweight: FontWeight.w300,
                    ),
                    verticalSpaceMedium,
                  ]));
        });
  }
//----------------------------------------------------
}
