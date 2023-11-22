import 'package:flutter_modular/flutter_modular.dart';

import '../../core/common/app_settings/routes/bookscase_module_routes.dart';
import '../app_module.dart';
import 'features/data/datasource/i_download_e_book_datasource.dart';
import 'features/data/datasource/i_get_all_books_datasource.dart';
import 'features/data/datasource_impl/download_e_book_datasource_impl.dart';
import 'features/data/datasource_impl/get_all_books_datasource_impl.dart';
import 'features/data/repositories_impl/download_e_book_repository_impl.dart';
import 'features/data/repositories_impl/get_all_books_repository_impl.dart';
import 'features/domain/repositories/i_download_e_book_repository.dart';
import 'features/domain/repositories/i_get_all_books_repository.dart';
import 'features/domain/usecases/download_e_book_usecase.dart';
import 'features/domain/usecases/get_all_books_usecase.dart';
import 'features/presenter/controllers/bookscase_home_controller.dart';
import 'features/presenter/ui/views/bookscase_home.dart';

class BookscaseModule extends Module {
  @override
  void binds(Injector i) {
    //usercase
    i.add<GetAllBooksUsecase>(GetAllBooksUsecase.new);
    i.add<DownloadEBookUsecase>(DownloadEBookUsecase.new);

    //repositories
    i.add<IGetAllBooksRepository>(GetAllBooksRepositoryImpl.new);
    i.add<IDownloadEBookRepository>(DownloadEBookRepositoryImpl.new);

    //datasource
    i.add<IGetAllBooksDatasource>(GetAllBooksDatasourceImpl.new);
    i.add<IDownloadEBookDatasource>(DownloadEBookDatasourceImpl.new);

    //controllers
    i.add<BookscaseHomeController>(BookscaseHomeController.new);
  }

  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void routes(RouteManager r) {
    r.child(BookscaseModuleRoutes.bookscaseMain,
        child: (context) => const BookscaseHome());
  }
}
