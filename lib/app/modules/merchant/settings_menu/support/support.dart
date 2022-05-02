import 'package:deposits_ecommerce/app/common/utils/exports.dart';

import 'package:intl/intl.dart';

class Support extends StatefulWidget {
  Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> with WidgetsBindingObserver {
  SupportController controller = Get.put(SupportController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchSupportCategory(context);
    controller.issueController.text = '';
    controller.orderController.text = '';
    controller.issueController.addListener(() {
      if (mounted) setState(() {});
    });
    controller.orderController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchSupportCategory(context);
    }
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
        title: Strings.support,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        if (controller.isError.value) {
          return CustomNoInternetRetry(
            message: controller.errorMessage.value,
            onPressed: () {
              controller.fetchSupportCategory(context);
            },
            title: Strings.error,
          );
        }
        return GetBuilder<SupportController>(
            builder: (controller) => supportContainer());
      }),
    );
  }

//-------------------------------------------------------
  Widget supportContainer() {
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
                      child: Column(children: [
                    supportDesc(),
                    orderContainer(),
                    supportCategory(),
                    issueInput()
                  ])),
                  // bottom content
                  Column(
                    children: [sendMessageButton(), depositsLogo()],
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
  Widget supportDesc() {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: (18)),
      child: const CustomText(
        text: Strings.supportDesc,
        txtAlign: TextAlign.center,
        font: Dimens.fontSize16,
        fntweight: FontWeight.w300,
      ),
    );
  }

//-------------------------------------------------------
  Widget supportCategory() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: 
        DropdownWidget(
          currentItem: controller.productType,
          items: controller.productTypeList,
          title: Strings.supportCategory,
          itemCallBack: (value) => setState(() {
            controller.productType = value;
          }),
          validator: (value) => value == null ? Strings.fieldCantBeEmpty : null,
        )
        );
  }
//-------------------------------------------------------
  Widget orderContainer() {
    return Container(
        child: TypeAheadField<OrderData>(
            hideSuggestionsOnKeyboardHide: false,
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller.orderController,
              decoration: InputDecoration(
                hintText: Strings.selectOrder,
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor,),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.borderColor,),
                ),
                hintStyle: AppTextStyle.regularStyle.copyWith(
                  fontSize: Dimens.fontSize14,
                  color: AppColors.black,
                ),
                fillColor: Colors.white,
                contentPadding:const EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
            suggestionsCallback: controller.getUserSuggestions,
            itemBuilder: (context, OrderData? orderData) {
              final order = orderData!;
              return CustomListTileWidget(
                title: order.products![0].name!,
                subTitle: order.products!.length == 1
                    ? order.products!.length.toString() + ' product'
                    : order.products!.length.toString() + ' products',
                contentPadding:
                    const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 0),
                leading: SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipOval(
                      child: PNetworkImage(
                    order.products![0].assets!.isNotEmpty
                        ? order.products![0].assets![0].url!
                        : Constants.noAssetImageAvailable,
                    fit: BoxFit.cover,
                  )),
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: '\$' + order.amount!.toString(),
                      fntweight: FontWeight.w500,
                    ),
                    verticalSpaceTiny,
                    CustomText(
                        text: DateFormat('h:mma').format(order.createdAt!),
                        font: Dimens.fontSize13),
                  ],
                ),
              );
            },
            noItemsFoundBuilder: (context) => const SizedBox(
                  height: 100,
                  child:  Center(
                      child: CustomText(text: Strings.noOrdersAvailable)),
                ),
            onSuggestionSelected: (OrderData? orderData) {
              final order = orderData!;
              controller.chosenOrder.value = order;
              controller.orderController.text = order.products![0].name!;
            }),
        margin: const EdgeInsets.symmetric(vertical: 10.0));
  }
//-------------------------------------------------------
  Widget issueInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.issueController,
        keyboardType: TextInputType.text,
        addHint: true,
        maxLines: 8,
        minLines: 3,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.enterIssue,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//-------------------------------------------------------
  Widget sendMessageButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () {
            controller.sendMg(context);
          },
          minWidth: Get.width,
          title: Strings.sendMessage,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: controller.validateInput()
                  ? AppColors.black
                  : AppColors.white),
          buttonColor: controller.validateInput()
              ? AppColors.activButtonColor
              : AppColors.inActivButtonColor,
        )));
  }
//-------------------------------------------------------
}
