import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../utils/utils.dart';

class Constants {
  //base url
  static Future<String> baseUrl() async {
    bool isDev = await Utils.getEnviromentMode();
    var url = '';
    if (isDev) {
      url = dotenv.env['baseUrlSandbox'].toString();
    } else {
      url = dotenv.env['baseUrlLive'].toString();
    }
    // print('URL $url - $isDev');
    return url;
  }

  static Future<String> apiKey() async {
    bool isDev = await Utils.getEnviromentMode();
    // print("isDev $isDev");
    var key = '';
    if (isDev) {
      key = dotenv.env['sdkApiKeySandbox'].toString();
    } else {
      key = dotenv.env['sdkApiKeyLive'].toString();
    }
    // print("api key $key");
    return key;
  }

  static String oneClickApiKey()  {
    bool isDev =  Utils.getEnviromentMode();
    // print("isDev $isDev");
    var key = '';
    if (isDev) {
      key = dotenv.env['API_KEY_TEST'].toString();
    } else {
      key = dotenv.env['sdkApiKeyLive'].toString();
    }
    // print("one click api key $key");
    return key;
  }

  static const String noAssetImageAvailable =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1200px-No-Image-Placeholder.svg.png';
  //timeout interval
  static const timeout = Duration(seconds: 30);
  static const String subClientApiKey = 'sub_client_api_key';
  static const String envMode = 'envMode';
  static const String merchantID = 'merchantId';
  static const String customerID = 'customerID';
  static const String customColor = 'custom_color';
  static const String customerEmail = 'customer_mail';
}
