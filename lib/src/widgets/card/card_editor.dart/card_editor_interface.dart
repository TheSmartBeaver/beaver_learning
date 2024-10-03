import 'package:beaver_learning/src/models/enum/card_displayer_type.dart';
import 'package:flutter/widgets.dart';

abstract class CardEditorInterface extends Widget {
  const CardEditorInterface({super.key});

  Future<void> createOrUpdateCard(int groupId);
  Future<void> showCard(BuildContext context);
  Future<void> initEditorWithAssembly(int assemblyId, BuildContext context);
}
