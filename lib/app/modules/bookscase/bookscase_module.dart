import 'package:escribo_app_teste_2/app/core/common/app_settings/routes/bookscase_module_routes.dart';
import 'package:escribo_app_teste_2/app/modules/app_module.dart';
import 'package:escribo_app_teste_2/app/modules/bookscase/features/data/datasource/i_get_all_books_datasource.dart';
import 'package:escribo_app_teste_2/app/modules/bookscase/features/data/datasource_impl/get_all_books_datasource_impl.dart';
import 'package:escribo_app_teste_2/app/modules/bookscase/features/data/repositories_impl/get_all_books_repository_impl.dart';
import 'package:escribo_app_teste_2/app/modules/bookscase/features/domain/repositories/i_get_all_books_repository.dart';
import 'package:escribo_app_teste_2/app/modules/bookscase/features/presenter/ui/views/bookscase_home.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'features/domain/usecases/get_all_books_usecase.dart';

class BookscaseModule extends Module {
  @override
  void binds(Injector i) {
    //usercase
    i.add<GetAllBooksUsecase>(GetAllBooksUsecase.new);

    //repositories
    i.add<IGetAllBooksRepository>(GetAllBooksRepositoryImpl.new);

    //datasource
    i.add<IGetAllBooksDatasource>(GetAllBooksDatasourceImpl.new);
  }

  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(BookscaseModuleRoutes.booksCaseMain,
        child: (context) => const BookscaseHome());
  }
}
