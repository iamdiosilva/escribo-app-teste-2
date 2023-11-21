import 'package:dartz/dartz.dart';

import '../../../../../core/common/error/failures.dart';
import '../entities/e_book_entity.dart';

abstract class IGetAllBooksRepository {
  Future<Either<Failure, List<EBookEntity>>> getAllBooks();
}
