
import 'package:deposits_ecommerce/app/common/utils/exports.dart';

class AppColors{
  // const AppColors._();
  static const Color darkBackgroudColor = Color(0xFF212934);
  static const Color whiteBackgroundColor = Color(0xFFE5E5E5);
  // static const Color activButtonColor = Color(0xFF0DB9E9);
    static Color activButtonColor() {
    var storedcolor = Storage.getValue(Constants.customColor);
    if (storedcolor == null) {
      return const Color(0xFF0DB9E9);
    } else {
      return Color(Utils.hexToInt(Storage.getValue(Constants.customColor)));
    }
  }
  // static const Color inActivButtonColor = Color(0xFFBDF3FC);
  static Color inActivButtonColor() {
    var storedcolor = Storage.getValue(Constants.customColor);
    if (storedcolor == null) {
      return const Color(0xFFBDF3FC);
    } else {
      return Color(Utils.hexToInt(Storage.getValue(Constants.customColor)));
    }
  }
  // static const Color borderButtonColor = Color(0xFF0D7FE9);
  static Color borderButtonColor() {
    var storedcolor = Storage.getValue(Constants.customColor);
    if (storedcolor == null) {
      return const Color(0xFF4C97FA);
    } else {
      return Color(Utils.hexToInt(Storage.getValue(Constants.customColor)));
    }
  }
  // static const Color borderButtonColor2 = Color(0xFF0DB9E9);
   static Color borderButtonColor2() {
    var storedcolor = Storage.getValue(Constants.customColor);
    if (storedcolor == null) {
      return const Color(0xFF0DB9E9);
    } else {
      return Color(Utils.hexToInt(Storage.getValue(Constants.customColor)));
    }
  }
  static const Color doneButtonColor = Color(0xFFF5F8FA);
  static const Color saveInfoContainerColor = Color(0xFFF7FBFF);
  static const Color hintColor = Color(0xFF8895A7);
  static const Color borderColor = Color(0xFFC0C4C9);
  static const Color declineColor = Color(0xFFF5F5F5);
  static const Color doveGray = Color(0xFF646464);
  static const Color mineShaft = Color(0xFF2B2B2B);
  static const Color black = Color(0xFF000000);
  static const Color red = Colors.red;
  static const Color green = Color(0xFF00B058);
  static const Color availableTagBackground = Color(0xFFEDFFF9);
  static const Color inActiveTagBackground = Color(0xFFF5F8FA);
  static const Color outOfStockTagBackground = Color(0xffFFF0F2);
  static const Color availableTagTextColor = Color(0xFF1D3B32);
  static const Color inActiveTagTextColor = Color(0xFF212934);
  static const Color outOfStockTagTextColor = Color(0xFF331418);
  static const Color white = Color(0xFFFFFFFF);
}