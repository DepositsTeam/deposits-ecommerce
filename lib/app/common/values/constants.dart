 import '../../../deposits_ecommerce.dart';

class Constants {
  //base url
  static Future<String> baseUrl() async {
    bool isDev = await Utils.getEnviromentMode();
    print("isDev baseurl $isDev");
    var url = '';
    if (isDev) {
      url = dotenv.env['baseUrlSandbox'].toString();
      // url = Storage.getValue('baseUrlSandbox').toString();
      print('derived staging base url is $url');
    } else {
      url = dotenv.env['baseUrlLive'].toString();
      // url = Storage.getValue('baseUrlLive').toString();
      print('derived prod base url is $url');
    }
    // print('URL $url - $isDev');
    return url;
  }

  static Future<String> apiKey() async {
    bool isDev = await Utils.getEnviromentMode();
    print("isDev apikey $isDev");
    var key = '';
    if (isDev) {
      key = dotenv.env['sdkApiKeySandbox'].toString();
      // key = Storage.getValue('sdkApiKeySandbox').toString();
      print('derived staging api key is $key');
    } else {
      key = dotenv.env['sdkApiKeyLive'].toString();
      // key = Storage.getValue('sdkApiKeyLive').toString();
      print('derived prod api key is $key');
    }
    // print("api key $key");
    return key;
  }

  static bool setOneClickEnvMode() {
    bool isDev = Utils.getEnviromentMode();
    if (isDev) {
      return true;
    } else {
      return false;
    }
  }

  static String oneClickApiKey() {
    bool isDev = Utils.getEnviromentMode();
    print("isDev $isDev");
    var key = '';
    if (isDev) {
      key = dotenv.env['API_KEY_TEST'].toString();
    } else {
      key = dotenv.env['sdkApiKeyLive'].toString();
    }
    // print("one click api key $key");
    return key;
  }

  static String orderApiKey() {
    bool isDev = Utils.getEnviromentMode();
    // print("isDev $isDev");
    var key = '';
    if (isDev) {
      key = dotenv.env['sdkApiKeySandbox'].toString();
      // key = Storage.getValue('sdkApiKeySandbox').toString();
      print('derived staging api key is $key');
    } else {
      key = dotenv.env['sdkApiKeyLive'].toString();
      // key = Storage.getValue('sdkApiKeyLive').toString();
      print('derived prod api key is $key');
    }
    // print("api key $key");
    return key;
  }

  static String orderBaseUrl() {
    bool isDev = Utils.getEnviromentMode();
    var url = '';
    if (isDev) {
      url = dotenv.env['baseUrlSandbox'].toString();
      // url = Storage.getValue('baseUrlSandbox').toString();
      print('derived staging base url is $url');
    } else {
      url = dotenv.env['baseUrlLive'].toString();
      // url = Storage.getValue('baseUrlLive').toString();
      print('derived prod base url is $url');
    }
    // print('URL $url - $isDev');
    return url;
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
