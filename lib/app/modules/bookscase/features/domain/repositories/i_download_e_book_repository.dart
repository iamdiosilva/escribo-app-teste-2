import 'package:dartz/dartz.dart';

import '../../../../../core/common/error/failures.dart';

abstract class IDownloadEBookRepository {
  Future<Either<Failure, String>> downloadEbook(String ebookUrl);
}
