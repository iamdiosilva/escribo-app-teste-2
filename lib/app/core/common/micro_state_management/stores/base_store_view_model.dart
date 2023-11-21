import 'base_store.dart';
import 'base_store_view_model_widgets.dart';

abstract class BaseStoreViewModel {
  final BaseStore store;

  StoreViewModelWidgets get widgets;

  const BaseStoreViewModel({
    required this.store,
  });
}
