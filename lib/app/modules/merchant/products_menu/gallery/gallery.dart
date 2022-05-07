import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AssetsGallery extends StatefulWidget {
  AssetsGallery({Key? key}) : super(key: key);

  @override
  State<AssetsGallery> createState() => _AssetsGalleryState();
}

class _AssetsGalleryState extends State<AssetsGallery>with WidgetsBindingObserver {
  AssetsGalleryController controller = Get.put(AssetsGalleryController());

 @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchGallery(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchGallery(context);
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
        title: Strings.productGallery,
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
                    },
                    child: CustomSvgimage(image: AppImages.add))),
          ]
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return  galleryContainer();
      }),
    );
  }
//------------------------------------------------------
  Widget galleryContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
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
                        children: [allGalleryAssets()])),
                // bottom content
                Column(
                  children: [uploadButton(),depositsLogo()],
                )
              ]))));
    });
  }
//------------------------------------------------------
//------------------------------------------------------
  Widget allGalleryAssets() {
    return Flexible(
            child: controller.allAssets.isEmpty
        ? Container(
            child: const Center(
              child: CustomText(text: 'No search results found'),
            ),
          )
        : GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: (5)),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing:30.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: .8,
                  crossAxisCount: 3),
              itemCount: controller.allAssets.length,
              itemBuilder: (_, i) {
                var item = controller.allAssets[i];
                return InkWell(
                  onTap: () {
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: PNetworkImage(
                           item.url ?? Constants.noAssetImageAvailable,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
//------------------------------------------------------
  Widget uploadButton() {
    return Obx(() => Container(
        margin: const EdgeInsets.symmetric(vertical: (20)),
        child: CustomElevatedButton(
          onPressed: () {},
          minWidth: Get.width,
          title: Strings.addProduct,
          isBusy: controller.isLoading.value,
          textStyle: TextStyle(
              color: controller.selectedAssets.isNotEmpty
                  ? AppColors.black
                  : AppColors.white),
          buttonColor: controller.selectedAssets.isNotEmpty
              ? AppColors.activButtonColor()
              : AppColors.inActivButtonColor(),
        )));
  }
//------------------------------------------------------
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
//------------------------------------------------------
}