import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class Allpayments extends StatefulWidget {
  Allpayments({Key? key, }) : super(key: key);

  @override
  State<Allpayments> createState() => _AllpaymentsState();
}

class _AllpaymentsState extends State<Allpayments>with WidgetsBindingObserver {
  AllPaymentsController controller = Get.put(AllPaymentsController());

 @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchOrders(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchOrders(context);
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
        title: Strings.allPayment,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Utils.loader();
        }
        return GetBuilder<AllPaymentsController>(
            builder: (controller) => addPaymentsContainer());
      }),
    );
  }

//-------------------------------------------------------
  Widget addPaymentsContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      return ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
              child: Column(mainAxisSize: MainAxisSize.max, children: [
            //top content
            Expanded(
              child: Obx(() =>Column(
                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                    searchContainer(),
                    allPayments()
                  ])),
            ),
            // bottom content
            Column(
              children: [depositsLogo()],
            )
          ])));
    });
  }

//-------------------------------------------------------
 Widget searchContainer(){
   return Padding(
      padding: const EdgeInsets.symmetric(horizontal: (15), vertical: 9),
      child:CustomTextFieldWidget(
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
                ));
 }
//-------------------------------------------------------
  Widget allPayments() {
    return  Expanded(
            child: controller.items.isEmpty
        ? Container(
            child: const Center(
              child: CustomText(text: 'No search results found'),
            ),
          )
        :ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: (15)),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.items.length,
                itemBuilder: (_, i) {
                  var item = controller.items[i];
                  return CustomListTileWidget(
              title: item.products![0].name!,
              onTap: () {
                Utils.navigationPush(
                    context,
                    PaymentDetails(
                      orderData: item,
                    ));
              },
              subTitle: item.products!.length==1 ?item.products!.length.toString() + ' product' : item.products!.length.toString() + ' products',
              contentPadding:
                  const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
              leading: SizedBox(
                height: 50, width: 50,
                child: ClipOval(
                    child: PNetworkImage(item.products![0].assets!.isNotEmpty ?  item.products![0].assets![0].url! : Constants.noAssetImageAvailable,
                        fit: BoxFit.cover, )),
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
                  CustomText(text: DateFormat('h:mma')
                        .format(item.createdAt!), txtColor:const Color(0xff8895A7),font: Dimens.fontSize13),
                ],
              ),
            );
                }),
          );
  }

//-------------------------------------------------------
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

}
