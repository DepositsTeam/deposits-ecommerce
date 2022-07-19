import 'package:deposits_ecommerce/app/common/utils/exports.dart';
class ShopSettings extends StatefulWidget {
  final DepositsEcommerceContext? shopContext;
  const ShopSettings({Key? key, this.shopContext}) : super(key: key);

  @override
  State<ShopSettings> createState() => _ShopSettingsState();
}

class _ShopSettingsState extends State<ShopSettings> {
  ShopSettingsController controller = Get.put(ShopSettingsController());
  
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
        title: Strings.shopSetting,
        textSize: (Dimens.fontSize16),
        onBackPress: () {
          Navigator.pop(context);
        },
      ),
      body: shopSettingsContainer(),
    );
  }

//-------------------------------------------------------
  Widget shopSettingsContainer() {
    return LayoutBuilder(builder: (context, constraints) {
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
                        children: [settingsOptions()])),
                // bottom content
                Column(
                  children: [depositsLogo()],
                )
              ]))));
    });
  }

//-------------------------------------------------------
  Widget depositsLogo() {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Offstage(
      offstage: isKeyboardOpen,
      child: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.symmetric(vertical: (5)),
          child: CustomSvgimage(image: AppImages.depositsLogo,
          width: 200,
          )),
    );
  }

//-------------------------------------------------------
  Widget settingsOptions() {
    return Column(
      children: [
        CustomListTileWidget(
          leading: CustomSvgimage(image: AppImages.shopDetails,color:AppColors.activButtonColor()),
          title: Strings.shopDetails,
          onTap: () {
            Utils.navigationPush(
                context,
                ShopDetail());
          },
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.borderColor,
            size: Dimens.fontSize22,
          ),
          subTitle: '',
        ),
        Divider(
          color: AppColors.hintColor.withOpacity(0.5),
          height: 1,
        ),
        CustomListTileWidget(
          leading: CustomSvgimage(image: AppImages.taxes, color: AppColors.activButtonColor()),
          title: Strings.taxFees,
          onTap: () {
            Utils.navigationPush(
                context,
                TaxFee());
            
          },
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.borderColor,
            size: Dimens.fontSize22,
          ),
          subTitle: '',
        ),
        Divider(
          color: AppColors.hintColor.withOpacity(0.5),
          height: 1,
        ),
        CustomListTileWidget(
          leading: CustomSvgimage(image: AppImages.viewStore, color: AppColors.activButtonColor()),
          title: 'View store as a user',
          onTap: () {
            Utils.navigationPush(
                context,
                AllCustomers());
          },
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.borderColor,
            size: Dimens.fontSize22,
          ),
          subTitle: '',
        ),
        Divider(
          color: AppColors.hintColor.withOpacity(0.5),
          height: 1,
        ),
        CustomListTileWidget(
          leading: CustomSvgimage(image: AppImages.shipping, color: AppColors.activButtonColor()),
          title: Strings.shippingReturnPolicy,
          onTap: () {
            Utils.navigationPush(
                context,
                ShippingPolicy( ));
          },
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.borderColor,
            size: Dimens.fontSize22,
          ),
          subTitle: '',
        ),
        Divider(
          color: AppColors.hintColor.withOpacity(0.5),
          height: 1,
        ),
        CustomListTileWidget(
          leading: CustomSvgimage(image: AppImages.contactAddress,
              color: AppColors.activButtonColor()),
          title: Strings.contactAddress,
          onTap: () {
            Utils.navigationPush(
                context,
                ContactAddress());
          },
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.borderColor,
            size: Dimens.fontSize22,
          ),
          subTitle: '',
        ),
        Divider(
          color: AppColors.hintColor.withOpacity(0.5),
          height: 1,
        ),
        CustomListTileWidget(
          leading: CustomSvgimage(image: AppImages.support, color: AppColors.activButtonColor()),
          title: Strings.support,
          onTap: () {
            Utils.navigationPush(
                context,
                Support());
          },
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.borderColor,
            size: Dimens.fontSize22,
          ),
          subTitle: '',
        ),
        Divider(
          color: AppColors.hintColor.withOpacity(0.5),
          height: 1,
        ),
        CustomListTileWidget(
          leading: CustomSvgimage(image: AppImages.deleteShop, color: AppColors.activButtonColor()),
          title: Strings.deleteMyShop,
          onTap: () {
            Utils.navigationReplace(
                context,
                DeleteAccount(shopContext: widget.shopContext));
          },
          trailing: const Icon(
            Icons.arrow_forward_ios_sharp,
            color: AppColors.borderColor,
            size: Dimens.fontSize22,
          ),
          subTitle: '',
        ),
        Divider(
          color: AppColors.hintColor.withOpacity(0.5),
          height: 1,
        )
      ],
    );
  }

//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------

}
