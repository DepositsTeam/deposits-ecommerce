
import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:intl/intl.dart';

class PaymentDetails extends StatefulWidget {
   OrderData? orderData;
  PaymentDetails({Key? key,this.orderData}) : super(key: key);

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  PaymentDetailsController controller = Get.put(PaymentDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.declineColor,
       appBar: CustomAppbarWidget(
          centerTitle: true,
          addBackButton: true,
          backgroundColor: AppColors.activButtonColor(),
          backbuttonColor: AppColors.white,
          textColor: AppColors.white,
          title: "#"+widget.orderData!.uuid!,
          textSize: (Dimens.fontSize16),
          onBackPress: () {
            Navigator.pop(context);
          },
        ),
      body: paymentDetailsContainer()
    );
  }
//-------------------------------------------------------
  Widget paymentDetailsContainer() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                  child:
                      Column(mainAxisSize: MainAxisSize.max, children: [
                        //top content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              fromWho(),
                              paymentDetails(),
                            ])),
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
          margin: const EdgeInsets.only(bottom: (20)),
          child: CustomSvgimage(image: AppImages.depositsLogo,
            width: 200,
          )),
    );
  }
//-------------------------------------------------------
Widget fromWho(){
  return Container(
    color: AppColors.activButtonColor(),
    height: 200,
    alignment: Alignment.topCenter,
    width: Get.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomSvgimage(image: AppImages.income),
        verticalSpaceMedium,
        CustomText(text: '\$'+widget.orderData!.amount!.toString(),txtColor: AppColors.white, font: Dimens.fontSize32, fntweight: FontWeight.w600, ),
        verticalSpaceSmall,
        CustomText(text: widget.orderData!.customer!.email??'', txtColor: AppColors.white,font: Dimens.fontSize16, fntweight: FontWeight.w400, ),
        const SizedBox(height: 20,)
      ],
    ),
  );
}
//-------------------------------------------------------
Widget paymentDetails(){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: (15)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        verticalSpaceMedium,
        //status
        CustomTextTag(
        text: widget.orderData!.status!,
        status: widget.orderData!.status!,
      ),
      verticalSpaceSmall,
        verticalSpaceTiny,
        //amount
        const CustomText(
          text: Strings.totalAmount,
          font: Dimens.fontSize14,
          fntweight: FontWeight.w400,
          txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        CustomText(
          text: '\$'+widget.orderData!.amount!.toString(),
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
          txtColor: const Color(0xff575B68),
        ),
        verticalSpaceSmall,
        verticalSpaceTiny,
        //payment id
       const CustomText(
          text: Strings.paymentId,
          font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
              txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        CustomText(
          text: '#'+widget.orderData!.uuid!.toString(),
          font: Dimens.fontSize16,
              fntweight: FontWeight.w600,
              txtColor: const Color(0xff575B68),
        ),
        verticalSpaceSmall,
        verticalSpaceTiny,
        //payment type
       const CustomText(
          text: Strings.paymentType,
          font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
              txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        CustomText(
          text: widget.orderData!.transactionId!,
          font: Dimens.fontSize16,
              fntweight: FontWeight.w600,
              txtColor: const Color(0xff575B68),
        ), 
        verticalSpaceSmall,
        verticalSpaceTiny,
        //order id
        const CustomText(
          text: Strings.orderID,
          font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
              txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        CustomText(
          text: '#'+widget.orderData!.uuid!,
          font: Dimens.fontSize16,
              fntweight: FontWeight.w600,
              txtColor: const Color(0xff575B68),
        ),
        verticalSpaceSmall,
        verticalSpaceTiny,
        //product ids
        const CustomText(
          text: Strings.productIds,
          font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
              txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        Row(children: widget.orderData!.products!.map((item) => 
         CustomProductTag(
        text:'#'+item.uuid!,
        status: widget.orderData!.status!,
        containerColor: widget.orderData!.status== 'Available' || widget.orderData!.status== 'Completed' || widget.orderData!.status == 'active'  ? AppColors.availableTagBackground : widget.orderData!.status == 'inactive' ? AppColors.inActiveTagBackground : AppColors.outOfStockTagBackground,
        textColor: widget.orderData!.status== 'Available' || widget.orderData!.status== 'Completed' || widget.orderData!.status == 'active' ? AppColors.availableTagTextColor: widget.orderData!.status == 'inactive' ? AppColors.inActiveTagTextColor : AppColors.outOfStockTagTextColor,
         ),
        ).toList()),
        verticalSpaceSmall,
        verticalSpaceTiny,
        //payment name
        const CustomText(
          text: Strings.productname,
          font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
              txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        Column(children: widget.orderData!.products!.map((item) => 
         CustomText(
          text: item.name!,
          font: Dimens.fontSize16,
                        fntweight: FontWeight.w600,
                        txtColor: const Color(0xff575B68),
        ),
        ).toList()),
        verticalSpaceSmall,
        verticalSpaceTiny,
        //delivery address
        const CustomText(
          text: Strings.deliveryAddress,
          font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
              txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        CustomText(
          text: widget.orderData!.streetAddress!.toTitleCase(),
          font: Dimens.fontSize16,
              fntweight: FontWeight.w600,
              txtColor: const Color(0xff575B68),
        ),
        verticalSpaceSmall,
        verticalSpaceTiny,
        //time
        const CustomText(
          text: Strings.time,
          font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
              txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        CustomText(
          text: DateFormat('h:mma')
                        .format(widget.orderData!.createdAt!),
          font: Dimens.fontSize16,
              fntweight: FontWeight.w600,
              txtColor: const Color(0xff575B68),
        ),
        verticalSpaceSmall,
        verticalSpaceTiny,
        //porder staus
        const CustomText(
          text: Strings.orderStatus,
          font: Dimens.fontSize14,
              fntweight: FontWeight.w400,
              txtColor: Color(0xff9598A3),
        ),
        verticalSpaceTiny,
        CustomText(
          text: widget.orderData!.status!.toTitleCase(),
          font: Dimens.fontSize16,
          fntweight: FontWeight.w600,
          txtColor: const Color(0xff575B68),
        ),
        verticalSpaceSmall,
            verticalSpaceTiny,
      ],
    )
  );
}
//-------------------------------------------------------
//-------------------------------------------------------
//-------------------------------------------------------
}