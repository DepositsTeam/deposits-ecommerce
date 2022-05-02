import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class EditProduct extends StatefulWidget {
  final ProductData data;
  const EditProduct({Key? key, required this.data})
      : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  EditProductController controller = Get.put(EditProductController());

  @override
  void initState() {
    controller.fetchProductCategory(context);
    controller.productName.text = (widget.data.name ?? '').toTitleCase();
    controller.productPrice.text = widget.data.price ?? '';
    controller.productQuantity.text = widget.data.quantity ?? '';
    controller.productDetails.text = (widget.data.description ?? '').toTitleCase();
    controller.enterTax.text = widget.data.tax ?? '';
    controller.extraFee.text = widget.data.shippingFee ?? '';
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

    controller.selectedImagePaths.clear();
    for (var item in widget.data.assets!) {
      controller.selectedImagePaths.add(item.id!.toString());
      // print('total is: '+controller.selectedImagePaths.toString());
    }

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
        title: Strings.editProduct,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return GetBuilder<EditProductController>(
            builder: (controller) => editProductContainer());
      }),
    );
  }

//-------------------------------------------------------
  Widget editProductContainer() {
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
                         controller.isIncludeTaxFee.isTrue
                            ? taxInput()
                            : const SizedBox(),
                        controller.isIncludeTaxFee.isTrue
                            ? extraInput()
                            : const SizedBox(),
                        addMoreImages(),
                        imageSelector(),
                      ])),
                  // bottom content
                  Column(
                    children: [editProductButton(), depositsLogo()],
                  )
                ]))));
      }),
    );
  }

//-------------------------------------------------------
  Widget editProductButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () {
            controller.editProduct(context, widget.data.id.toString());
          },
          minWidth: Get.width,
          title: Strings.saveChanges,
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
  Widget imageSelector() {
    return GetBuilder<EditProductController>(
        builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.start,
                  spacing: 12,
                  runSpacing: 15,
                  children: [
                    // ...imageWidgets
                    Stack(
                      children: [
                        ImageSelector(
                          url: widget.data.assets!.isEmpty?null : widget.data.assets!.asMap().containsKey(0) ?  widget.data.assets![0].url : null,
                          onSelect: (path) {
                            if (path.picturePath != null) {
                              controller.createAsset(context,path, 0);
                            } else {
                             var assetIndex =   controller.selectedImagePaths[0];
                          controller.deleteAssets(context,widget.data.id.toString(),assetIndex.toString(), 0);
                            }
                          },
                        ),
                      ],
                    ),
                    ImageSelector(
                      url: widget.data.assets!.isEmpty?null : widget.data.assets!.asMap().containsKey(1) ?  widget.data.assets![1].url : null,
                      onSelect: (path) {
                        if (path.picturePath != null) {
                           controller.createAsset(context,path, 1);
                        } else {
                          var assetIndex =  controller.selectedImagePaths[1];
                          controller.deleteAssets(context,widget.data.id.toString(),assetIndex.toString(), 1);
                        }
                      },
                    ),
                    ImageSelector(
                      url: widget.data.assets!.isEmpty?null : widget.data.assets!.asMap().containsKey(2) ?  widget.data.assets![2].url : null,
                      onSelect: (path) {
                        if (path.picturePath != null) {
                           controller.createAsset(context,path, 2);
                        } else {
                          var assetIndex =  controller.selectedImagePaths[2];
                          controller.deleteAssets(context,widget.data.id.toString(),assetIndex.toString(), 2);
                        }
                      },
                    ),
                    ImageSelector(
                      url: widget.data.assets!.isEmpty?null : widget.data.assets!.asMap().containsKey(3) ?  widget.data.assets![3].url : null,
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 3);
                        } else {
                          var assetIndex =  controller.selectedImagePaths[3];
                          controller.deleteAssets(context,widget.data.id.toString(),assetIndex.toString(), 3);
                        }
                      },
                    ),
                    ImageSelector(
                      url: widget.data.assets!.isEmpty?null : widget.data.assets!.asMap().containsKey(4) ?  widget.data.assets![4].url : null,
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 4);
                        } else {
                          var assetIndex =  controller.selectedImagePaths[4];
                          controller.deleteAssets(context,widget.data.id.toString(),assetIndex.toString(), 4);
                        }
                      },
                    ),
                    ImageSelector(
                      url: widget.data.assets!.isEmpty?null : widget.data.assets!.asMap().containsKey(5) ?  widget.data.assets![5].url : null,
                      onSelect: (path) {
                        if (path.picturePath != null) {
                          controller.createAsset(context,path, 5);
                        } else {
                           var assetIndex =  controller.selectedImagePaths[5];
                          controller.deleteAssets(context,widget.data.id.toString(),assetIndex.toString(), 5);
                        }
                      },
                    ),
                  ]),
            ));
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
  Widget extraInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.extraFee,
        keyboardType: TextInputType.number,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.extrafee,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
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
  Widget includeTaxFess() {
    return CheckboxListTile(
      // value: (widget.data.tax =='0' && widget.data.shippingFee =='0')? controller.isIncludeTaxFee.value : true,
      value: controller.isIncludeTaxFee.value,
      activeColor: AppColors.green,
      checkColor: AppColors.white,
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      title:const CustomText(
        text: Strings.includeTaxFees,
        font: Dimens.fontSize14,
        fntweight: FontWeight.w400,
        txtColor: AppColors.doveGray,
      ),
      onChanged: (value) {
        controller.toggleIsIncludeTaxFee(value!);
      },
    );
  }

//-------------------------------------------------------
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
  Widget productType() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownWidget(
          currentItem: widget.data.categoryId,
          items: controller.productTypeList,
          title: Strings.storeCategory,
          itemCallBack: (value) => setState(() {
            controller.productType = value;
            widget.data.categoryId = value;
          }),
          validator: (value) => value == null ? Strings.fieldCantBeEmpty : null,
        )
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
  Widget productNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.productName,
        capitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
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
}
