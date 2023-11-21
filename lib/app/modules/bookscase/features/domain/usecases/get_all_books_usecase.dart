import 'package:dartz/dartz.dart';

import '../../../../../core/common/error/failures.dart';
import '../../../../../core/common/usecase/i_future_usecase.dart';
import '../../../../../core/common/usecase/no_params.dart';

import '../entities/e_book_entity.dart';
import '../repositories/i_get_all_books_repository.dart';

class GetAllBooksUsecase
    implements IFutureUsecase<List<EBookEntity>, NoParams> {
  GetAllBooksUsecase(this._getAllBooksUsecase);
  final IGetAllBooksRepository _getAllBooksUsecase;

  @override
  Future<Either<Failure, List<EBookEntity>>> call(NoParams params) {
    return _getAllBooksUsecase.getAllBooks();
  }
}
