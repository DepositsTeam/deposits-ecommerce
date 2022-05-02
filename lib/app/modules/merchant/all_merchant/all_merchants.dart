import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AllMerchants extends StatefulWidget {
  AllMerchants({Key? key,}) : super(key: key);

  @override
  State<AllMerchants> createState() => _AllMerchantsState();
}

class _AllMerchantsState extends State<AllMerchants>
    with WidgetsBindingObserver {
  AllMerchantsController controller = Get.put(AllMerchantsController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchMerchants(context);
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
      controller.fetchMerchants(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        centerTitle: true,
        addBackButton: true,
        title: Strings.allMerchants,
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
              controller.fetchMerchants(context);
            },
            title: Strings.error,
          );
        }
        return GetBuilder<AllMerchantsController>(
            builder: (controller) => allMerchantsContainer());
      }),
    );
  }

  Widget allMerchantsContainer() {
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
                      children: [searchContainer(), merchantsContainer()])),
              // bottom content
              Column(children: [
                setUpShopButton(),
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
        hintText: 'Search merchants',
        onChanged: (value) => controller.filterSearchResults(value!),
        textInputAction: TextInputAction.search,
      ),
    );
  }

//------------------------------------------------
  Widget merchantsContainer() {
    return Expanded(
        child: controller.allMerchants.isEmpty
            ? Container(
                child: const Center(
                  child: CustomText(text: 'No search results found'),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: (20)),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.allMerchants.length,
                itemBuilder: (_, i) {
                  var item = controller.allMerchants[i];
                  return CustomListTileWidget(
                    title: item.name ?? '',
                    subTitle: item.supportEmail ?? '',
                    leading: CircleAvatar(
                      maxRadius: 20,
                      backgroundColor: Colors.blueGrey.shade100,
                      child: CustomText(
                          text: Utils.getInitials(item.name!),
                          fntweight: FontWeight.bold,
                          txtColor: Colors.blueGrey.shade800,
                          font: 10),
                    ),
                    onTap: () {
                      Storage.removeValue(Constants.merchantID);
                      Storage.saveValue(
                          Constants.merchantID, item.id.toString());
                      Utils.navigationReplace(
                          context,
                          Dashboard(
                              merchantID: item.id.toString()));
                    },
                  );
                }));
  }

//------------------------------------------------
  Widget setUpShopButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: (20), horizontal: 20),
      child: CustomElevatedButton(
        onPressed: () {
          controller.setUpShop(context,);
        },
        minWidth: Get.width,
        addBorder: true,
        title: Strings.setUpShop,
        textColor: AppColors.borderButtonColor,
        buttonColor: AppColors.white,
        loaderColor: AppColors.borderButtonColor,
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
          child: CustomSvgimage(image: AppImages.depositsLogo)),
    );
  }
//------------------------------------------------

}
