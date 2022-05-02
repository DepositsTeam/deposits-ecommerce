import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class EcomPayments extends StatefulWidget {
  final String merchantID;
  EcomPayments({Key? key, required this.merchantID})
      : super(key: key);

  @override
  State<EcomPayments> createState() => _EcomPaymentsState();
}

class _EcomPaymentsState extends State<EcomPayments>
    with WidgetsBindingObserver {
  EcomPaymentsController controller = Get.put(EcomPaymentsController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.loadContent(context, widget.merchantID);
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
      controller.loadContent(context, widget.merchantID);
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
        title: Strings.payments,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
        actions: controller.items.isNotEmpty
            ? [
                Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CustomInkwellWidget(
                        onTap: () {
                          filterItem();
                        },
                        child: CustomSvgimage(image: AppImages.filter))),
                Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: CustomInkwellWidget(
                        onTap: () {
                          controller.hideShowSearch();
                        },
                        child: CustomSvgimage(image: AppImages.search))),
              ]
            : null,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        if (controller.isError.value) {
          return CustomNoInternetRetry(
            message: controller.errorMessage.value,
            onPressed: () {
              controller.loadContent(context, widget.merchantID);
            },
            title: Strings.error,
          );
        }
        return paymentsContainer(context);
      }),
    );
  }

//-------------------------------------------------------
  Widget paymentsContainer(BuildContext context) {
    return Form(
      child: LayoutBuilder(builder: (context, constraints) {
        return ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
                child: Column(mainAxisSize: MainAxisSize.max, children: [
              //top content
              //if no payment exist
              controller.items.isEmpty
                  ? Expanded(
                      child: Column(children: [
                      shopDesc(),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSvgimage(
                            image: AppImages.noPayments,
                          ),
                          verticalSpaceTiny,
                          const CustomText(
                            text: Strings.noPaymentYet,
                            txtAlign: TextAlign.center,
                          ),
                          verticalSpaceTiny,
                          const CustomText(
                            text: Strings.allPaymentShowHere,
                            txtAlign: TextAlign.center,
                            font: Dimens.fontSize15,
                            fntweight: FontWeight.w200,
                          ),
                          verticalSpaceSmall,
                        ],
                      ))
                    ]))
                  : Expanded(
                      child: Obx(() => Column(children: [
                            controller.isSearchItemVisible.isFalse
                                ? shopDesc()
                                : searchContainer(),
                            controller.isSearchItemVisible.isFalse &&
                                    controller.items.isNotEmpty
                                ? exportOrders(context)
                                : const SizedBox(),
                            allPayments()
                          ]))),

              // bottom content
               Obx(() => controller.hideShowLogo.isTrue? Column(
              children: [depositsLogo()],
            ):const SizedBox()
              )
            ])));
      }),
    );
  }
//-------------------------------------------------------
  Widget noPaymentData() {
    return Obx(() => Column(children: [
          shopDesc(),
          const SizedBox(
            height: 20,
          ),
          Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomSvgimage(
                            image: AppImages.noPayments,
                          ),
                          verticalSpaceTiny,
                          const CustomText(
                            text: Strings.noPaymentYet,
                            txtAlign: TextAlign.center,
                          ),
                          verticalSpaceTiny,
                          const CustomText(
                            text: Strings.allPaymentShowHere,
                            txtAlign: TextAlign.center,
                            font: Dimens.fontSize15,
                            fntweight: FontWeight.w200,
                          ),
                          verticalSpaceSmall,
                        ],
                      )),
          //bottome
          Column(
            children: [depositsLogo()],
          )
        ]));
  }

//-------------------------------------------------------
  Widget payymentDataAvailable(BuildContext context) {
    return Obx(() => ListView(children: [
          controller.isSearchItemVisible.isFalse
              ? shopDesc()
              : searchContainer(),
          controller.isSearchItemVisible.isFalse && controller.items.isNotEmpty
              ? exportOrders(context)
              : const SizedBox(),
          allPayments(),
          //bottom
          depositsLogo()
        ]));
  }

//-------------------------------------------------------
  Widget depositsLogo() {
    return Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.symmetric(vertical: (5)),
          child: CustomSvgimage(image: AppImages.depositsLogo,
          width: 200,
        )
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
                  text: Strings.pendingBalance,
                  fntweight: FontWeight.w400,
                  font: Dimens.fontSize16,
                ),
                verticalSpaceSmall,
                CustomRowTextWidget(
                    title: '\$' + controller.pendingBalanceWhole,
                    titleStyle: const TextStyle(
                        color: AppColors.black,
                        fontSize: Dimens.fontSize24,
                        fontWeight: FontWeight.w600),
                    subtitle: '.' + controller.pendingBalanceDecimal,
                    subtitleStyle: const TextStyle(
                        color: AppColors.black,
                        fontSize: Dimens.fontSize20,
                        fontWeight: FontWeight.w600),
                    mainAxisAlignment: MainAxisAlignment.center),
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
                  text: Strings.walletbalance,
                  fntweight: FontWeight.w400,
                  font: Dimens.fontSize16,
                ),
                verticalSpaceSmall,
                CustomRowTextWidget(
                    title: '\$' + controller.walletBalanceWhole.toString(),
                    titleStyle: const TextStyle(
                        color: AppColors.black,
                        fontSize: Dimens.fontSize24,
                        fontWeight: FontWeight.w600),
                    subtitle: '.' + controller.walletBalanceDecimal.toString(),
                    subtitleStyle: const TextStyle(
                        color: AppColors.black,
                        fontSize: Dimens.fontSize20,
                        fontWeight: FontWeight.w600),
                    mainAxisAlignment: MainAxisAlignment.center),
              ],
            )),
          ],
        )));
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
                  hintText: 'Search payment name, ID',
                  onChanged: (value) => controller.filterSearchResults(value!),
                  textInputAction: TextInputAction.search,
                  prefixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: AppColors.doveGray,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
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
  Widget allPayments() {
    return Expanded(
      child: controller.items.isEmpty
          ? Container(
              child: const Center(
                child: CustomText(text: 'No search results found'),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(left: (15), right: 15, bottom: 20),
              shrinkWrap: true,
              controller: controller.scrollController,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.items.length,
              itemBuilder: (_, i) {
                var item = controller.items[i];
                return Obx(() => CustomListTileCheckBoxWidget(
                      title: "#" + item.uuid!,
                      selector: controller.isExportSelector.value,
                      onSelect: (value) {
                        controller.updateExportList(i, value);
                      },
                      onTap: () {
                        Utils.navigationPush(
                            context,
                            PaymentDetails(orderData: item,
                            ));
                      },
                      subTitle: item.products!.length == 1
                          ? item.products!.length.toString() + ' product'
                          : item.products!.length.toString() + ' products',
                      contentPadding: const EdgeInsets.only(
                          left: 0, right: 0, bottom: 10, top: 20),
                      leading: ClipOval(
                          child: PNetworkImage(
                              item.products![0].assets!.isNotEmpty
                                  ? item.products![0].assets![0].url!
                                  : Constants.noAssetImageAvailable,
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50)),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText(
                            text: '\$' + item.amount!.toString(),
                            fntweight: FontWeight.w500,
                          ),
                          verticalSpaceTiny,
                          CustomText(
                              text: DateFormat('h:mma').format(item.createdAt!),
                              font: Dimens.fontSize13),
                        ],
                      ),
                    ));
              }),
    );
  }

//-------------------------------------------------------
  Widget exportOrders(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: (15), vertical: (10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      CustomSvgimage(image: AppImages.download),
                      horizontalSpaceSmall,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          CustomText(
                              text: Strings.exportOrders,
                              fntweight: FontWeight.w500),
                          verticalSpaceTiny,
                          CustomText(
                            text: Strings.sendOrders,
                            font: Dimens.fontSize13,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 79,
                height: 32,
                child: Obx(() => CustomElevatedButton(
                      onPressed: () {
                        controller.paymentIds.isEmpty
                            ? controller.hideShowExportSelector()
                            : exportSheet(context);
                      },
                      title: 'Select',
                      textStyle: TextStyle(
                          color: controller.isExportSelector.value
                              ? AppColors.black
                              : AppColors.white),
                      buttonColor: controller.isExportSelector.value
                          ? AppColors.activButtonColor
                          : AppColors.inActivButtonColor,
                    )),
              )
            ],
          ),
          verticalSpaceMedium,
          GetBuilder<EcomPaymentsController>(
              builder: (controller) => CustomText(
                    text: controller.totalOrdersSelected.toString() +
                        " orders selected",
                    font: Dimens.fontSize15,
                    txtAlign: TextAlign.start,
                    fntstyle: FontStyle.normal,
                    fntweight: FontWeight.w700,
                  ))
        ],
      ),
    );
  }

  void filterItem() {
    showModalBottomSheet(
      context: context,
      elevation: 4,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      enableDrag: true,
      builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            // You can wrap this Column with Padding of 8.0 for better design
            child: Form(
              key: controller.formKey,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 15, bottom: 15),
                  child: SingleChildScrollView(
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
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: AppColors.borderColor,
                                ))
                          ],
                        ),
                        verticalSpaceMedium,
                        CustomTextFieldWidget(
                          controller: controller.paymentDate,
                          keyboardType: TextInputType.text,
                          addHint: true,
                          validator: null,
                          hintText: Strings.paymentDate,
                          textInputAction: TextInputAction.search,
                          suffixIcon: IconButton(
                            icon: CustomSvgimage(
                              image: AppImages.calendar,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        verticalSpaceSmall,
                        CustomTextFieldWidget(
                          controller: controller.paymentIdController,
                          keyboardType: TextInputType.text,
                          addHint: true,
                          validator: null,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp('[\\.|\\,]')),
                          ],
                          hintText: Strings.paymentId,
                          textInputAction: TextInputAction.done,
                        ),
                        verticalSpaceSmall,
                        CustomTextFieldWidget(
                          controller: controller.amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          addHint: true,
                          validator: null,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d{0,2}')),
                          ],
                          hintText: Strings.amount,
                          textInputAction: TextInputAction.next,
                        ),
                        verticalSpaceSmall,
                        DropdownWidget(
                          currentItem: controller.paymentStatus,
                          items: controller.paymentStatusList,
                          title: Strings.paymentStatus,
                          itemCallBack: (value) => setState(() {
                            controller.paymentStatus = value;
                          }),
                          validator: (value) =>
                              value == null ? Strings.fieldCantBeEmpty : null,
                        ),
                        verticalSpaceSmall,
                        CustomTextFieldWidget(
                          controller: controller.productNameController,
                          keyboardType: TextInputType.text,
                          addHint: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                                RegExp('[\\.|\\,]')),
                          ],
                          validator: null,
                          hintText: Strings.productname,
                          textInputAction: TextInputAction.done,
                        ),
                        verticalSpaceSmall,
                        Obx(() => CustomElevatedButton(
                              onPressed: () => {
                                controller.selectFilterResults(
                                  context: context,
                                  paymentId:
                                      controller.paymentIdController.text,
                                  paymentStatus: controller.paymentStatus,
                                  amount: controller.amountController.text,
                                  productName:
                                      controller.productNameController.text,
                                )
                              },
                              minWidth: Get.width,
                              title: Strings.filter,
                              isBusy: controller.isFilterLoading.value,
                              textStyle: TextStyle(
                                  color: controller.validateInput() == false
                                      ? AppColors.white
                                      : AppColors.black),
                              buttonColor: controller.validateInput() == false
                                  ? AppColors.inActivButtonColor
                                  : AppColors.activButtonColor,
                            )),
                        verticalSpaceSmall,
                      ],
                    ),
                  )),
            ));
      },
    ).whenComplete(() => {
          // if (
          //   controller.productNameController.text.isEmpty &&
          //   controller.amountController.text.isEmpty &&
          //   controller.paymentDate.text.isEmpty &&
          //   controller.paymentIdController.text.isEmpty &&
          //   controller.paymentStatus.isEmpty
          // ) {
          //   controller.items.clear(),
          // controller.items.addAll(controller.tempItems)
          // } else {
          // }
        });
  }

//-------------------------------------------------------
  void exportSheet(BuildContext context) {
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
            return Container(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 15, bottom: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomInkwellWidget(
                            onTap: () {},
                            child: const Icon(
                              Icons.close,
                              color: AppColors.white,
                            )),
                        const CustomText(
                          text: Strings.exportOrders,
                          font: Dimens.fontSize16,
                          fntweight: FontWeight.w700,
                        ),
                        CustomInkwellWidget(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.close,
                              color: AppColors.borderColor,
                            ))
                      ],
                    ),
                    verticalSpaceMedium,
                    CustomText(
                      text: controller.totalOrdersSelected > 1
                          ? 'Export all ' +
                              controller.totalOrdersSelected.toString() +
                              ' orders'
                          : 'Export order',
                      font: Dimens.fontSize15,
                      fntweight: FontWeight.w500,
                    ),
                    verticalSpaceMedium,
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: (20)),
                        child: Obx(() => CustomElevatedButton(
                              onPressed: () => {
                                controller.exportSeletedOrders(
                                  context,
                                  controller.exportData,
                                ),
                              },
                              minWidth: Get.width,
                              title: Strings.export,
                              isBusy: controller.isBottomLoading.value,
                              textStyle:
                                  const TextStyle(color: AppColors.black),
                              buttonColor: AppColors.activButtonColor,
                            ))),
                    verticalSpaceMedium,
                  ],
                ));
          });
        });
  }
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
}
//PDCCJ22