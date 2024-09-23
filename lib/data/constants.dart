import 'dart:io';

class AppConstante {

  static const String AppTitle = 'FlashMemorize Pro';
  static const String templateNameKey = 'template_name';
  static const String templatedPreviewNameKey = "templated_preview";

  static RegExp markerRegExp = RegExp(r'{{.*}}');

  static String rectoFieldName = "recto";
  static String versoFieldName = "verso";
  static String htmlSupportFieldName = "support";
  static String templateFieldName = "template_name";

    static const String profileProviderStateKey = "profileProviderStateKey";
}
