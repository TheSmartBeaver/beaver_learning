import 'package:beaver_learning/src/models/provider_state/app_bar_state.dart';
import 'package:beaver_learning/src/widgets/shared/app_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppbarNotifier extends StateNotifier<AppBarState> {
  AppbarNotifier() : super(AppBarState());

  void changeSelectedDrawerIndex(DrawerItem currentDrawerIndex) {
    state.currentDrawerIndex = currentDrawerIndex;
  }
}

final appbarProvider =
    StateNotifierProvider<AppbarNotifier, AppBarState>((ref) {
  return AppbarNotifier();
});
