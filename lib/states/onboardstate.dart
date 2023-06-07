import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import 'mainstate.dart';

final onBoardState =
    ChangeNotifierProvider.autoDispose<OnBoardState>((ref) => OnBoardState());

class OnBoardState extends ChangeNotifier {
  final swipeController = LiquidController();

  int index = 0;

  void setPage(int value) {
    index = value;
    notifyListeners();
  }

  Future<void> nextPage(BuildContext context) async {
    MainState mainState = MainState();
    await mainState.init();
    if (index < 2) {
      swipeController.jumpToPage(page: index + 1);
    } else {
      await mainState.setOnboard(true);
      context.go("/login");
    }
    notifyListeners();
  }
}
