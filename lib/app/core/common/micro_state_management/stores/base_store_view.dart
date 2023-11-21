import 'package:flutter/material.dart';

import '../state/states.dart';
import 'base_store_view_model.dart';

abstract class BaseStoreView extends StatelessWidget {
  final BaseStoreViewModel viewModel;

  const BaseStoreView({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RawState>(
      valueListenable: viewModel.store,
      builder: (context, state, child) {
        final widget = viewModel.widgets.get(state, context);
        return widget;
      },
    );
  }
}
