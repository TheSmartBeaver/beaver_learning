import 'package:flutter/widgets.dart';

abstract class CardEditorInterface extends Widget {
  const CardEditorInterface({super.key});

  Future<void> createCard(int groupId);
}
