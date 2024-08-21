import 'dart:io';

class AppConstante {

  static const String AppTitle = 'FlashMemorize Pro';
  static const String templateNameKey = 'template_name';
  static const String templatedCardPreviewNameKey = "templated_card_preview";

  static RegExp markerRegExp = RegExp(r'{{.*}}');
}
