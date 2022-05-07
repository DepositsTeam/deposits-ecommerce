import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AllCustomers extends StatefulWidget {
  AllCustomers({Key? key,}) : super(key: key);

  @override
  State<AllCustomers> createState() => _AllCustomersState();
}

class _AllCustomersState extends State<AllCustomers>
    with WidgetsBindingObserver {
  AllCustomersController controller = Get.put(AllCustomersController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchCustomers(context);
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
      controller.fetchCustomers(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        centerTitle: true,
        addBackButton: true,
        title: Strings.allCustomers,
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
         if (controller.isError.value) {
          return CustomNoInternetRetry(
            message: controller.errorMessage.value,
            onPressed: () {
              controller.fetchCustomers(context);
            },
            title: Strings.error,
          );
        }
        return GetBuilder<AllCustomersController>(
            builder: (controller) => allCustomersContainer());
      }),
    );
  }

  Widget allCustomersContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top content
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [searchContainer(), customersContainer()])),
              // bottom content
              Column(children: [
                addCustomerButton(),
                depositsLogo(),
              ]),
            ],
          )));
    });
  }

//----------------------------------------------------
  Widget searchContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: (9), horizontal: 20),
      child: CustomTextFieldWidget(
        controller: controller.searchController,
        keyboardType: TextInputType.text,
        addHint: true,
        validator: null,
        hintText: 'Search customers',
        onChanged: (value) => controller.filterSearchResults(value!),
        textInputAction: TextInputAction.search,
      ),
    );
  }

//------------------------------------------------
  Widget customersContainer() {
    return Expanded(
        child: controller.allCustomers.isEmpty
            ? Container(
                child: const Center(
                  child: CustomText(text: 'No search results found'),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: (20)),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.allCustomers.length,
                itemBuilder: (_, i) {
                  var item = controller.allCustomers[i];
                  return CustomListTileWidget(
                    title: "${item.firstName ?? ''} ${item.lastName ?? ''}",
                    subTitle: item.email ?? '',
                    leading: CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Colors.blueGrey.shade100,
                      child: CustomText(
                          text: Utils.getInitials(
                              "${item.firstName ?? ''} ${item.lastName ?? ''}"),
                          fntweight: FontWeight.bold,
                          txtColor: Colors.blueGrey.shade800,
                          font: 10),
                    ),
                    onTap: () {
                      Storage.removeValue(Constants.customerID);
                      Storage.saveValue(Constants.customerID, item.id);
                      Utils.navigationPush(
                          context,
                          ViewAsUserShops(
                              merchantId:
                                  Storage.getValue(Constants.merchantID),
                          )
                        );
                    },
                  );
                }));
  }

//------------------------------------------------
  Widget addCustomerButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (20), horizontal: 20),
      child: CustomElevatedButton(
        onPressed: () {
          controller.addCustomer(context,);
        },
        minWidth: Get.width,
        addBorder: true,
        title: Strings.createCustomer,
        textColor: AppColors.borderButtonColor(),
        buttonColor: AppColors.white,
        loaderColor: AppColors.borderButtonColor(),
      ),
    );
  }

//------------------------------------------------
  Widget depositsLogo() {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Offstage(
      offstage: isKeyboardOpen,
      child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(
            bottom: (20),
          ),
          child: CustomSvgimage(image: AppImages.depositsLogo,
            width: 200,
          )),
    );
  }
//------------------------------------------------
}
