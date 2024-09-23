import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplatedCardNotifier extends StateNotifier<TemplatedCardState> {
  TemplatedCardNotifier() : super(TemplatedCardState());

  bool hasRootCardTemplatedBranchChanged(bool hasChanged) {
    return state.rootCardTemplatedBranchChangedMarker != hasChanged;
  }

  void makeRootCardTemplatedBranchChange() {
    state.rootCardTemplatedBranchChangedMarker = !state.rootCardTemplatedBranchChangedMarker;
  }
}

final templatedCardProvider =
    StateNotifierProvider<TemplatedCardNotifier, TemplatedCardState>((ref) {
  return TemplatedCardNotifier();
});

class TemplatedCardState {
  bool rootCardTemplatedBranchChangedMarker = false;
} 