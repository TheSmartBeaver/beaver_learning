import 'package:beaver_learning/src/utils/classes/card_classes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TemplatedCardNotifier extends StateNotifier<TemplatedCardState> {
  TemplatedCardNotifier() : super(TemplatedCardState());

  void initRootCardTemplatedBranch(CardTemplatedBranch cardTemplatedBranch) {
    state.rootCardTemplatedBranch = cardTemplatedBranch;
  }

  bool hasRootCardTemplatedBranchChanged(bool hasChanged) {
    return state.rootCardTemplatedBranchChangedMarker != hasChanged;
  }

  void makeRootCardTemplatedBranchChange() {
    state.rootCardTemplatedBranchChangedMarker = !state.rootCardTemplatedBranchChangedMarker;
  }

  get rootCardTemplatedBranch => state.rootCardTemplatedBranch;
}

final templatedCardProvider =
    StateNotifierProvider<TemplatedCardNotifier, TemplatedCardState>((ref) {
  return TemplatedCardNotifier();
});

class TemplatedCardState {
  CardTemplatedBranch? rootCardTemplatedBranch;
  bool rootCardTemplatedBranchChangedMarker = false;
} 