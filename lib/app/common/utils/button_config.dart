
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class ButtonConfig {
  final String buttonText;
  final TextStyle? textStyle;
  final double height, minWidth;
  final Widget? titleWidget;
  final Color buttonColor, buttonBorderColor, textColor, loaderColor;
  final bool addBorder;
  final bool isBusy;

  const ButtonConfig({
    required this.buttonText,
    this.textStyle,
    this.height = 55,
    this.minWidth = 100,
    this.buttonColor = AppColors.activButtonColor,
    this.buttonBorderColor = AppColors.borderButtonColor,
    this.textColor = AppColors.black,
    this.loaderColor = AppColors.white,
    this.titleWidget,
    this.addBorder = false,
    this.isBusy = false,
  });
}