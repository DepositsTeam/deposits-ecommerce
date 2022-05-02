import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AddProducts extends StatefulWidget {
  final DepositsEcommerceContext? shopContext;
  const AddProducts({Key? key, this.shopContext}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
   AddProductsController get controller {
    return Get.put(AddProductsController(shopContext: widget.shopContext));
  }
  // AddProductsController controller = Get.put(AddProductsController());

 @override
  void initState() {
    super.initState();
    controller.fetchProductCategory(context);
    controller.productName.text = '';
    controller.productPrice.text = '';
    controller.productQuantity.text = '';
    controller.productDetails.text = '';
    controller.enterTax.text = '';
    controller.extraFee.text = '';
    controller.productName.addListener(() {
       if (mounted) setState(() {});
    });
    controller.productPrice.addListener(() {
       if (mounted) setState(() {});
    });
    controller.productQuantity.addListener(() {
       if (mounted) setState(() {});
    });
    controller.productDetails.addListener(() {
       if (mounted) setState(() {});
    });
    controller.enterTax.addListener(() {
      if (mounted) setState(() {});
    });
    controller.extraFee.addListener(() {
       if (mounted) setState(() {});
    });
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
        title: Strings.addAproduct,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return GetBuilder<AddProductsController>(
            builder: (controller) => addProductsContainer());
      }),
    );
  }

//-------------------------------------------------------
  Widget addProductsContainer() {
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
                        productNameInput(),
                        productPriceInput(),
                        productType(),
                        productQuantityInput(),
                        productDetailInput(),
                        includeTaxFess(),
                        controller.isIncludeTaxFee.isTrue? taxInput() : const SizedBox(),
                        controller.isIncludeTaxFee.isTrue? extraInput(): const SizedBox(),
                        addMoreImages(),
                        imageSelector(),
                      ])),
                  // bottom content
                  Column(
                    children: [addProductButton(), depositsLogo()],
                  )
                ]))));
      }),
    );
  }

//-------------------------------------------------------
  Widget productNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.productName,
        keyboardType: TextInputType.text,
        capitalization: TextCapitalization.sentences,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.productname,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
          UpperCaseTextFormatter()
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//-------------------------------------------------------
  Widget productPriceInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.productPrice,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.price,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//-------------------------------------------------------
  Widget productType() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownWidget(
          currentItem: controller.productType,
          items: controller.productTypeList,
          title: Strings.typeOfProduct,
          itemCallBack: (value) => setState(() {
            controller.productType = value;
          }),
          validator: (value) => value == null ? Strings.fieldCantBeEmpty : null,
        )
    );
  }

//-------------------------------------------------------
  Widget productQuantityInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.productQuantity,
        keyboardType: TextInputType.number,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.quantity,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//-------------------------------------------------------
  Widget productDetailInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.productDetails,
        keyboardType: TextInputType.text,
        capitalization: TextCapitalization.sentences,
        addHint: true,
        maxLines: 5,
        minLines: 5,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.productDetails,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
          UpperCaseTextFormatter()
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//-------------------------------------------------------
  Widget includeTaxFess() {
    return CheckboxListTile(
      value: controller.isIncludeTaxFee.value,
      activeColor: AppColors.green,
      checkColor: AppColors.white,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title: Row(
        children:const [
           CustomText(
            text: Strings.includeTaxFees,
            font: Dimens.fontSize14,
            fntweight: FontWeight.w400,
            txtColor: AppColors.doveGray,
          ),
          horizontalSpaceSmall,
          Icon(Icons.info_outline, color: AppColors.doveGray, size: 18, )
        ],
      ),
      onChanged: (value) {
        controller.toggleIsIncludeTaxFee(value!);
      },
    );
  }

//-------------------------------------------------------
  Widget taxInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.enterTax,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.enterTaxPer,
        inputFormatters: [
           FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//-------------------------------------------------------
  Widget extraInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.extraFee,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.extrafee,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//-------------------------------------------------------
  Widget addMoreImages() {
    return Container(
      color: const Color(0xffFFF8E7),
      height: (50),
      width: Get.width,
      margin: const EdgeInsets.symmetric(vertical: (10)),
      padding: const EdgeInsets.symmetric(vertical: (10), horizontal: (10)),
      child: const Center(
        child: CustomText(
          text: Strings.addMoreImages,
          font: (Dimens.fontSize14),
          fntweight: FontWeight.w500,
          txtColor: Color(0xff775D00),
          txtAlign: TextAlign.center,
        ),
      ),
    );
  }

//-------------------------------------------------------
  Widget imageSelector() {
    return GetBuilder<AddProductsController>(
        builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  spacing: 12,
                  runSpacing: 15,
                  children: [
                    ImageSelector(
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 0);
                        } else {
                        var assetIndex =  controller.selectedImagePaths[0];
                          controller.deleteAssets(context,assetIndex.toString(), 0);
                        }
                      },
                    ),
                    ImageSelector(
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 1);
                        } else {
                        var assetIndex =  controller.selectedImagePaths[1];
                          controller.deleteAssets(context,assetIndex.toString(), 1);
                        }
                      },
                    ),
                    ImageSelector(
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 2);
                        } else {
                        var assetIndex =  controller.selectedImagePaths[2];
                          controller.deleteAssets(context,assetIndex.toString(), 2);
                        }
                      },
                    ),
                    ImageSelector(
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 3);
                        } else {
                        var assetIndex =  controller.selectedImagePaths[3];
                          controller.deleteAssets(context,assetIndex.toString(), 3);
                        }
                      },
                    ),
                    ImageSelector(
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 4);
                        } else {
                        var assetIndex =  controller.selectedImagePaths[4];
                          controller.deleteAssets(context,assetIndex.toString(), 4);
                        }
                      },
                    ),
                    ImageSelector(
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 5);
                        } else {
                        var assetIndex =  controller.selectedImagePaths[5];
                          controller.deleteAssets(context,assetIndex.toString(), 5);
                        }
                      },
                    ),
                  ]),
            ));
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
  Widget addProductButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () {
            controller.addProduct(context);
          },
          minWidth: Get.width,
          title: Strings.addProduct,
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
