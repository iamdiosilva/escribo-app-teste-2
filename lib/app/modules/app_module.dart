import 'package:dio/dio.dart';
import 'package:escribo_app_teste_2/app/core/common/app_settings/routes/bookscase_module_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core/common/http_client/i_http/i_http_client.dart';
import '../core/common/http_client/impl/http_client_impl.dart';
import 'bookscase/bookscase_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add<Dio>(() => Dio());
    i.add<IHttpClient>(HttpClientImpl.new);
  }

  @override
  void routes(RouteManager r) {
    r.module(BookscaseModuleRoutes.bookscaseMain, module: BookscaseModule());
  }
}
