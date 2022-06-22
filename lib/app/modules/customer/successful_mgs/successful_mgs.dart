
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class SuccessfulMgs extends StatefulWidget {
  final String successTitle;
  final String successMessage;

  SuccessfulMgs({Key? key,
  required this.successTitle,
  required this.successMessage,
  }) : super(key: key);

  @override
  _SuccessfulMgsState createState() => _SuccessfulMgsState();
}

class _SuccessfulMgsState extends State<SuccessfulMgs> {
  SuccessfulMgsController controller = Get.put(SuccessfulMgsController());

 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: AppColors.white,
        key: controller.globalKey,
        appBar: CustomAppbarWidget(
          centerTitle: true,
          addBackButton: false,
          addCloseButton: true,
          backgroundColor: AppColors.white,
          closeButtonColor: AppColors.black,
          textColor: AppColors.black,
          title: '',
          textSize: (Dimens.fontSize16),
          onClosePress: () {
            Navigator.of(context).pop();
          },
        ),
        body: paymentSuccessfulBody(),
        bottomNavigationBar: doneWithPayment(),
    );
  }

//----------------------------------------------
  Widget paymentSuccessfulBody() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: (15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            txtAlign: TextAlign.center,
            text: widget.successTitle,
            font: (Dimens.fontSize20),
            fntweight: FontWeight.w700,
          ),
          verticalSpaceMedium,
          CustomText(
        txtAlign: TextAlign.center,
        text: widget.successMessage,
        font: (Dimens.fontSize14),
        fntweight: FontWeight.w400,
      ),
        ],
      ),
    );
  }

//----------------------------------------------
  Widget doneWithPayment() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: (15)),
      width: double.infinity,
      height: (120),
      child: ListView(shrinkWrap: true, children: [
        CustomElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          minWidth: Get.width,
          title: Strings.done,
          textStyle: const TextStyle(color: AppColors.black),
          buttonColor: AppColors.activButtonColor(),
        ),
        verticalSpaceSmall,
        Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: (20)),
            child: CustomSvgimage(image: AppImages.depositsLogo,
            width: 200,
          ),)
      ]),
    );
  }
//----------------------------------------------
}
