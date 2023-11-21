import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class IFutureUsecase<Output, Input> {
  Future<Either<Failure, Output>> call(Input params);
}
