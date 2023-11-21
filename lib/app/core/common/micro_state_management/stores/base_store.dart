import 'package:flutter/cupertino.dart';

import '../state/states.dart';

abstract class BaseStore extends ValueNotifier<RawState> {
  BaseStore() : super(const IdleState());

  emit(RawState state) {
    value = state;
  }
}
