import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class CreateCustomer extends StatefulWidget {
  CreateCustomer({Key? key, }) : super(key: key);

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer>
    with WidgetsBindingObserver {
  CreateCustomersController controller = Get.put(CreateCustomersController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    // controller.fetchMerchants(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // controller.fetchMerchants(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        centerTitle: true,
        addBackButton: true,
        title: Strings.createCustomer,
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
        return GetBuilder<CreateCustomersController>(
            builder: (controller) => addAddressBody());
      }),
    );
  }

//--------------------------------------------------------
  Widget addAddressBody() {
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
                              firstNameInput(),
                              lastNameInput(),
                              emailInput(),
                              phoneNumberInput(),
                              genderSelector(),
                              addressNameInput(),
                            ],
                          ),
                        ),

                        // bottom content
                        Column(
                          children: [createCustomerButton(), depositsLogo()],
                        )
                      ],
                    ),
                  )));
        }));
  }

//--------------------------------------------------------
  Widget firstNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.firstName,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.firstName,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//--------------------------------------------------------
  Widget lastNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.lastName,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmpty(value),
        hintText: Strings.lastName,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

//--------------------------------------------------------
  Widget emailInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.email,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: (value) => Validators.validateEmail(value),
        hintText: Strings.emailAddress,
        textInputAction: TextInputAction.next,
      ),
    );
  }

//--------------------------------------------------------
  Widget phoneNumberInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.phoneNumber,
        keyboardType: TextInputType.phone,
        addHint: true,
        validator: (value) => Validators.validatePhone(value),
        hintText: Strings.phoneNumber,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp('[\\.|\\,]')),
        ],
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget genderSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownWidget(
                          currentItem: controller.genderList.first,
                          items: controller.genderList,
                          title: Strings.gender,
                          itemCallBack: (value) => setState(() {
                            controller.gender = value;
                          }),
                          validator: (value) =>
                              value == null ? Strings.fieldCantBeEmpty : null,
                        ),
    );
  }

//--------------------------------------------------------
  Widget addressNameInput() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (10)),
      child: CustomTextFieldWidget(
        controller: controller.address,
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
  Widget createCustomerButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () {
            controller.createCustomer(context, );
          },
          minWidth: Get.width,
          title: Strings.createCustomer,
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
}
