import 'package:another_flushbar/flushbar.dart';
import 'package:deposits_ecommerce/app/common/utils/exports.dart';
import 'package:dio/dio.dart';

class Utils {
  // static bool envLoaded = false;

  static Widget loader() {
    return  Center(
      child: SpinKitFadingCircle(
        color: AppColors.activButtonColor(),
        size: 20,
      ),
    );
  }

  static bool getEnviromentMode()  {
    final envMode = Storage.getValue(Constants.envMode);
    // print('derived env $envMode');
    return envMode;
  }

  static String getInitials(String string) {
    List<String> names = string.split(" ");
    String initials = "";
    int numWords = 1;
    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }

  static Future navigationReplace(BuildContext context, Widget screen) async {
    return await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            settings: RouteSettings(name: '/${screen.toStringShort()}'),
            builder: (context) => screen));
  }

  static Future navigationPush(
    BuildContext context,
    Widget screen,
  ) async {
    // print('/${screen.toStringShort()}');
    return await Navigator.push(
        context,
        MaterialPageRoute(
            // settings: RouteSettings(name: '/${screen.toStringShort()}'),
            builder: (context) => screen));
  }

  static void showSnackbar(BuildContext context, String title, String message,
      Color backgroundColor) {
    Flushbar(
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(15),
            routeBlur: 20,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 5),
            title: title,
            message: message,
            backgroundColor: backgroundColor)
        .show(context);
  }

  static String handleErrorComing(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription = "${error.response?.data['message']}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  static loadEnvFile() async {
    // if (envLoaded == false) {
    await dotenv.load(
        fileName: 'packages/deposits_ecommerce/lib/app/common/assets/.env');
    // envLoaded = true;
    //   print("Env Loaded");
    // }
  }

  static int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw const FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

}
