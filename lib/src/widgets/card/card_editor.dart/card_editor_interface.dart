import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:flutter/widgets.dart';

abstract class CardEditorInterface extends Widget {
  const CardEditorInterface({super.key});

  Future<void> createCard(int groupId, CardDisplayerType displayerType);
  Future<void> showCard(BuildContext context);
}
