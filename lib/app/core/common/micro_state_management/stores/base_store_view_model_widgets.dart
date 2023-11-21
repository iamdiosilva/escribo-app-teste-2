import 'package:flutter/material.dart';

import '../state/states.dart';

class StoreViewModelWidgets {
  final Widget Function() idle;
  final Widget Function(SuccessState, BuildContext) success;
  final Widget Function(ErrorState, BuildContext) error;
  final Widget Function() loading;

  const StoreViewModelWidgets({
    required this.idle,
    required this.success,
    required this.error,
    required this.loading,
  });

  Widget get(RawState state, BuildContext context) {
    try {
      if (state is IdleState) {
        return idle();
      } else if (state is SuccessState) {
        return success(state, context);
      } else if (state is ErrorState) {
        return error(state, context);
      } else if (state is LoadingState) {
        return loading();
      }
      throw Exception('Unknown state: $state');
    } catch (e) {
      rethrow;
    }
  }
}
