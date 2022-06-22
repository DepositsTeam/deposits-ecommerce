import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class DeliveryAddress extends StatefulWidget {
  const DeliveryAddress({Key? key, }) : super(key: key);

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> with WidgetsBindingObserver {
  DeliveryAddressController controller = Get.put(DeliveryAddressController());

 @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    controller.fetchAddress(context);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      controller.fetchAddress(context);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbarWidget(
        centerTitle: true,
        addBackButton: true,
        title: Strings.deliveryAddress,
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
        return deliveryAddressBody();
      }),
    );
  }

//------------------------------------------------
  Widget deliveryAddressBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        //top content
        Column(
          children: [
            addMailButton(),
            allAddress(),
          ],
        ),
        //bottom content
        Column(
          children: [depositsLogo()],
        )
      ]),
    );
  }

//------------------------------------------------
 Widget allAddress(){
    return ListView.builder(
      shrinkWrap : true,
      padding:const EdgeInsets.symmetric(vertical: (10)),
      itemCount: controller.addresses.length,
      itemBuilder: (context, i) {
        var address = controller.addresses[i];
       return CustomListTileWidget(
          title: address.streetAddress??'null',
          onTap: (){
            controller.editMailingAddress(context,address);
            // Utils.navigationPush(context,EditAddress(
            //   initialScreen:widget.initialScreen,
            //   address: address,
            //   ));
          },
          subTitle: "${address.city ?? ''} ${address.state ?? ''} (${address.zip ?? ''}) ",
          leading: null,
          trailing: address.isDefaultAddress == 'true'? const CustomTextTag(text: Strings.defaultStr, status: 'Available',) : null,
          );
      },
    );
  }

//------------------------------------------------
  Widget depositsLogo() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: (30)),
      child: CustomSvgimage(image: AppImages.depositsLogo,
        width: 200,
      ),
    );
  }

//------------------------------------------------
  Widget addMailButton() {
    return CustomElevatedButton(
      onPressed: () {
        //  Utils.navigationPush(context, AddDeliveryAddress(initialScreen: widget.initialScreen));
          controller.addDeliveryAddress(context, );
      },
      minWidth: Get.width,
      addBorder: true,
      title: Strings.addDeliveryAddress,
      textColor: AppColors.borderButtonColor(),
      buttonColor: AppColors.white,
    );
  }
//------------------------------------------------
//------------------------------------------------
//------------------------------------------------
//------------------------------------------------
//------------------------------------------------
}
