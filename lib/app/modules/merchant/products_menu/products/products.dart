import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class Products extends StatefulWidget {
  final String merchantID;
  Products({Key? key, required this.merchantID})
      : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> with WidgetsBindingObserver {
  ProductsController get controller =>  Get.put(ProductsController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchProducts(context, widget.merchantID);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    controller.isError(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchProducts(context, widget.merchantID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.declineColor.withOpacity(0.5),
      appBar: CustomAppbarWidget(
        centerTitle: true,
        addBackButton: true,
        backgroundColor: AppColors.declineColor,
        backbuttonColor: AppColors.black,
        textColor: AppColors.black,
        title: Strings.products,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CustomInkwellWidget(
                  onTap: () {
                    controller.addProduct(context);
                    // controller.gallery(context, );
                  },
                  child: CustomSvgimage(image: AppImages.add))),
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CustomInkwellWidget(
                  onTap: () {
                    controller.hideShowSearch();
                  },
                  child: CustomSvgimage(image: AppImages.search))),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        if (controller.isError.value) {
          return CustomNoInternetRetry(
            message: controller.errorMessage.value,
            onPressed: () {
              controller.fetchProducts(context, widget.merchantID);
            },
            title: Strings.error,
          );
        }
        return shopProductsContainer(); //supportContainer();
      }),
    );
  }

//-------------------------------------------------------
  Widget shopProductsContainer() {
    return Form(
      child: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
              //top content
              //if no products exist
              controller.items.isEmpty
                  ? Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          CustomSvgimage(
                            image: AppImages.topUp,
                          ),
                          verticalSpaceTiny,
                          const CustomText(
                            text: Strings.addAproduct,
                            txtAlign: TextAlign.center,
                          ),
                          verticalSpaceTiny,
                          const CustomText(
                            text: Strings.addAProductDesc,
                            txtAlign: TextAlign.center,
                            font: Dimens.fontSize15,
                            fntweight: FontWeight.w200,
                          ),
                          verticalSpaceSmall,
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: CustomElevatedButton(
                              onPressed: () {
                                controller.addProduct(
                                    context);
                              },
                              title: Strings.addProduct,
                              textStyle:
                                  const TextStyle(color: AppColors.black),
                              buttonColor: AppColors.activButtonColor,
                            ),
                          )
                        ]))
                  :
                  // if products exist
                  Expanded(
                      child: Obx(() => Column(children: [
                            controller.isSearchItemVisible.isFalse
                                ? shopDesc()
                                : searchContainer(),
                            allShopProducts(),
                          ]))),

              // bottom content
              // Obx(() => controller.hideShowLogo.isTrue
              //     ? Column(
              //         children: [depositsLogo()],
              //       )
              //     : const SizedBox())
            ])));
      }),
    );
  }

//-------------------------------------------------------
  Widget supportContainer() {
    return Form(
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
                      child: Column(children: [
                    controller.items.isEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                CustomSvgimage(
                                  image: AppImages.topUp,
                                ),
                                verticalSpaceTiny,
                                const CustomText(
                                  text: Strings.addAproduct,
                                  txtAlign: TextAlign.center,
                                ),
                                verticalSpaceTiny,
                                const CustomText(
                                  text: Strings.addAProductDesc,
                                  txtAlign: TextAlign.center,
                                  font: Dimens.fontSize15,
                                  fntweight: FontWeight.w200,
                                ),
                                verticalSpaceSmall,
                                SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: CustomElevatedButton(
                                    onPressed: () {
                                      controller.addProduct(
                                          context);
                                    },
                                    title: Strings.addProduct,
                                    textStyle:
                                        const TextStyle(color: AppColors.black),
                                    buttonColor: AppColors.activButtonColor,
                                  ),
                                )
                              ])
                        : Column(children: [
                            controller.isSearchItemVisible.isFalse
                                ? shopDesc()
                                : searchContainer(),
                            allShopProducts(),
                          ])
                  ])),
                  // bottom content
                  Column(
                    children: [depositsLogo()],
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
          margin: const EdgeInsets.symmetric(vertical: (5)),
          child: CustomSvgimage(image: AppImages.depositsLogo)),
    );
  }

//-------------------------------------------------------
  Widget searchContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: (15), vertical: 9),
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
                  hintText: 'Search product',
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

//-------------------------------------------------------
  Widget shopDesc() {
    return Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: (18)),
        padding: const EdgeInsets.symmetric(horizontal: (15)),
        child: IntrinsicHeight(
            child: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                const CustomText(
                  text: Strings.totalQuantity,
                  fntweight: FontWeight.w400,
                  font: Dimens.fontSize16,
                ),
                verticalSpaceTiny,
                CustomText(
                  text: controller.totalQuantity.toString(),
                  fntweight: FontWeight.w600,
                  font: Dimens.fontSize26,
                ),
              ],
            )),
            const VerticalDivider(
              color: AppColors.borderColor,
              thickness: 1,
            ),
            Expanded(
                child: Column(
              children: [
                const CustomText(
                  text: Strings.totalSold,
                  fntweight: FontWeight.w400,
                  font: Dimens.fontSize16,
                ),
                verticalSpaceTiny,
                CustomText(
                  text: controller.totalSold.toString(),
                  fntweight: FontWeight.w600,
                  font: Dimens.fontSize26,
                ),
              ],
            )),
          ],
        )));
  }

//-------------------------------------------------------
  Widget allShopProducts() {
    return Flexible(
      child: controller.items.isEmpty
          ? Container(
              child: const Center(
                child: CustomText(text: 'No search results found'),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.only(left: (15), right: 15, bottom: 20),
              shrinkWrap: true,
              controller: controller.scrollController,
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
                        ProductDetails(
                          data: item,
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
                            height: 300,
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
              },
            ),
    );
  }

//-------------------------------------------------------
//-------------------------------------------------------
}
