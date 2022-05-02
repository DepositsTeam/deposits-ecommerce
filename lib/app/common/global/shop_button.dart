//pay with deposits button
// ignore_for_file: unnecessary_null_comparison

import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:deposits_ecommerce/app/modules/merchant/all_merchant/all_merchants.dart';

class ShopButton extends StatefulWidget {
  final BuildContext? context;
  final ButtonConfig buttonConfig;
  final String merchantID;
  final bool envMode;
  final String apiKey;

  ShopButton(
      {Key? key,
      this.context,
      required this.buttonConfig,
      required this.merchantID,
      required this.envMode,
      required this.apiKey,
      });
  @override
  _ShopButtonButtonState createState() => _ShopButtonButtonState();
}

class _ShopButtonButtonState extends State<ShopButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
       await Storage.removeValue(Constants.envMode);
       await Storage.removeValue(Constants.merchantID);
       await Storage.removeValue(Constants.subClientApiKey);
       await Storage.saveValue(Constants.merchantID, widget.merchantID);
       await Storage.saveValue(Constants.subClientApiKey, widget.apiKey);
       await Storage.saveValue(Constants.envMode, widget.envMode);
        //if merchant id is empty or null
        if (widget.merchantID.isEmpty || widget.merchantID==null) {
          Utils.navigationPush(
              context,
              AllMerchants());
        } else {
        //if not merchant id is not empty
        Utils.navigationPush(
            context,
            Dashboard(
                merchantID: widget.merchantID));
        }
      },
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.resolveWith<Size>(
          (states) => Size(
            widget.buttonConfig.minWidth,
            widget.buttonConfig.height,
          ),
        ),
        shape: widget.buttonConfig.addBorder
            ? MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                  side: BorderSide(
                    color: widget.buttonConfig.buttonColor ==
                            AppColors.activButtonColor
                        ? Colors.white
                        : widget.buttonConfig.buttonBorderColor,
                    width: 2,
                  ),
                ),
              )
            : MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }

            return null;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return widget.buttonConfig.buttonColor.withOpacity(.50);
            }
            return !widget.buttonConfig.isBusy
                ? widget.buttonConfig.buttonColor
                : widget.buttonConfig.buttonColor.withOpacity(0.6);
          },
        ),
      ),
      child: !widget.buttonConfig.isBusy
          ? widget.buttonConfig.titleWidget ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.buttonConfig.buttonText,
                    style: widget.buttonConfig.textStyle ??
                        AppTextStyle.boldStyle.copyWith(
                          fontSize: Dimens.fontSize14,
                          color:
                              widget.buttonConfig.buttonColor == Colors.white ||
                                      widget.buttonConfig.buttonColor ==
                                          Colors.transparent ||
                                      widget.buttonConfig.buttonColor ==
                                          AppColors.declineColor
                                  ? widget.buttonConfig.textColor
                                  : Colors.white,
                        ),
                  ),
                ],
              )
          : SpinKitFadingCircle(
              color: widget.buttonConfig.loaderColor,
              size: 20,
            ),
    );
  }
}
