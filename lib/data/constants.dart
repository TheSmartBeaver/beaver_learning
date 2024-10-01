import 'dart:io';

class AppConstante {
  AppConstante() {
    if (Platform.isIOS) {
      ApiUrl = "localhost:7299";
      //ApiUrl = "beaver-tech.com"; //VPS
    } else if (Platform.isAndroid) {
      //ApiUrl = "10.0.2.2:7239";
      ApiUrl = "192.168.86.136:7239";
      //ApiUrl = "beaver-tech.com"; //VPS
    }
    //ApiUrl = "62.72.18.73"; //VPS
  }

  static const String AppTitle = 'FlashMemorize Pro';
  static const String templateNameKey = 'template_name';
  static const String templatedPreviewNameKey = "templated_preview";

  static RegExp markerRegExp = RegExp(r'{{.*}}');

  static String rectoFieldName = "recto";
  static String versoFieldName = "verso";
  static String htmlSupportFieldName = "support";
  static String templateFieldName = "template_name";

  static const String profileProviderStateKey = "profileProviderStateKey";

  // static const String skuToBeDefined = "SKU_TO_BE_DEFINED";

  late String ApiUrl;
}
