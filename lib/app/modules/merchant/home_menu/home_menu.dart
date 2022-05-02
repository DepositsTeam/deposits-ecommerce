import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class HomeMenu extends StatefulWidget {
  final String merchantID;
  HomeMenu({Key? key, required this.merchantID})
      : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> with WidgetsBindingObserver {
  HomeMenuController controller = Get.put(HomeMenuController());

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchOrders(context, widget.merchantID);
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
      controller.fetchOrders(context, widget.merchantID);
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
        title: Strings.dashboard,
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
              controller.fetchOrders(context, widget.merchantID);
            },
            title: Strings.error,
          );
        }
        return controller.items.isNotEmpty
            ? payymentDataAvailable()
            : noPaymentData();
      }),
    );
  }

  // Widget homeContainer() {
  //   return LayoutBuilder(builder: (context, constraints) {
  //     return ConstrainedBox(
  //         constraints: BoxConstraints(
  //             minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
  //         child: IntrinsicHeight(
  //             child: Column(mainAxisSize: MainAxisSize.max, children: [
  //           //top content
  //           //no payment available
  //           Expanded(
  //               child: Obx(() => Column(children: [
  //                     shopDesc(),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     controller.items.isNotEmpty
  //                         ? seeAllPayments()
  //                         : SizedBox(),
  //                     controller.items.isNotEmpty
  //                         ? allPayments()
  //                         : Expanded(
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.center,
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 CustomSvgimage(
  //                                   image: AppImages.noPayments,
  //                                 ),
  //                                 verticalSpaceTiny,
  //                                 const CustomText(
  //                                   text: Strings.noPaymentYet,
  //                                   txtAlign: TextAlign.center,
  //                                 ),
  //                                 verticalSpaceTiny,
  //                                 const CustomText(
  //                                   text: Strings.allPaymentShowHere,
  //                                   txtAlign: TextAlign.center,
  //                                   font: Dimens.fontSize15,
  //                                   fntweight: FontWeight.w200,
  //                                 ),
  //                                 verticalSpaceSmall,
  //                               ],
  //                             ), //end of payment list
  //                           )
  //                   ]))),

  //           // bottom content
  //           Obx(() => controller.hideShowLogo.isTrue
  //               ? Column(
  //                   children: [depositsLogo()],
  //                 )
  //               : const SizedBox())
  //         ])));
  //   });
  // }

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
                  font: 21,
                  fntweight: FontWeight.w600,
                ),
                verticalSpaceTiny,
                const CustomText(
                  text: Strings.allPaymentShowHere,
                  txtAlign: TextAlign.center,
                  font: 16,
                  fntweight: FontWeight.w300,
                ),
              ],
            ),
          ),
          //bottome
          Column(
            children: [depositsLogo()],
          )
        ]));
  }

//-------------------------------------------------------
  Widget payymentDataAvailable() {
    return Obx(() => ListView(children: [
          shopDesc(),
          const SizedBox(
            height: 20,
          ),
          seeAllPayments(),
          const SizedBox(
            height: 10,
          ),
          allPayments(),
          //bottom
          depositsLogo()
        ]));
  }

//-------------------------------------------------------
  Widget depositsLogo() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: (25), top: 10),
        child: CustomSvgimage(
          image: AppImages.depositsLogo,
          width: 200,
        ));
  }

//-------------------------------------------------------
  Widget allPayments() {
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: (15),
        right: 15,
      ),
      shrinkWrap: true,
      controller: controller.scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.items.length,
      itemBuilder: (_, i) {
        var item = controller.items[i];
        return CustomListTileWidget(
          title: "#" + item.uuid!, //item.products![0].name!,
          onTap: () {
            Utils.navigationPush(
                context,
                PaymentDetails(
                  orderData: item,
                ));
          },
          subTitle: item.products!.length == 1
              ? item.products!.length.toString() + ' product'
              : item.products!.length.toString() + ' products',
          contentPadding:
              const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
          leading: SizedBox(
            height: 50,
            width: 50,
            child: ClipOval(
                child: PNetworkImage(
              item.products![0].assets!.isNotEmpty
                  ? item.products![0].assets![0].url!
                  : Constants.noAssetImageAvailable,
              fit: BoxFit.cover,
            )),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: '\$' + item.amount!.toString(),
                font: 16,
                fntweight: FontWeight.w600,
              ),
              verticalSpaceTiny,
              CustomText(
                  text: DateFormat('h:mma').format(item.createdAt!),
                  txtColor: const Color(0xff8895A7),
                  font: Dimens.fontSize13),
            ],
          ),
        );
      },
    );
  }

//-------------------------------------------------------
  Widget shopDesc() {
    return Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.symmetric(vertical: (18)),
        padding: const EdgeInsets.symmetric(horizontal: (15)),
        child: IntrinsicHeight(
            child: Column(
          children: [
            const CustomText(
              text: Strings.totalSales,
              fntweight: FontWeight.w400,
              txtColor: AppColors.black,
              font: 16,
            ),
            verticalSpaceTiny,
            CustomRowTextWidget(
                // crossAxisAlignment: CrossAxisAlignment.end,
                title: '\$' + controller.totalSalesWhole.toString(),
                titleStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: Dimens.fontSize32,
                    fontWeight: FontWeight.bold),
                subtitle: '.' + controller.totalSalesDecimal.toString(),
                subtitleStyle: const TextStyle(
                    color: AppColors.black,
                    fontSize: Dimens.fontSize22,
                    fontWeight: FontWeight.w600),
                mainAxisAlignment: MainAxisAlignment.center),
            verticalSpaceTiny,
            CustomText(
              text: controller.totalOrders.value.toString() + ' orders',
              fntweight: FontWeight.w600,
              font: 16,
              txtColor: Color(0xff8895A7),
            ),
          ],
        )));
  }

//-------------------------------------------------------
  Widget seeAllPayments() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: (15)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const CustomText(
            text: 'Payments',
            txtColor: AppColors.black,
            fntweight: FontWeight.w600,
          ),
          CustomText(
            text: 'See all',
            font: 14,
            txtColor: AppColors.borderButtonColor2,
            nav: () {
              Utils.navigationPush(
                  context,
                  Allpayments());
            },
          ),
        ]));
  }
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
}
