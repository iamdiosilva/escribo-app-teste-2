import 'package:dartz/dartz.dart';

import '../../../../../core/common/error/failures.dart';
import '../../domain/entities/e_book_entity.dart';
import '../../domain/repositories/i_get_all_books_repository.dart';
import '../datasource/i_get_all_books_datasource.dart';

class GetAllBooksRepositoryImpl implements IGetAllBooksRepository {
  final IGetAllBooksDatasource _getAllBooksDatasource;

  GetAllBooksRepositoryImpl(this._getAllBooksDatasource);

  @override
  Future<Either<Failure, List<EBookEntity>>> getAllBooks() async {
    try {
      final result = await _getAllBooksDatasource.getAllBooks();
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
