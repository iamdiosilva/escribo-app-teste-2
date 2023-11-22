import 'package:dartz/dartz.dart';

import '../../../../../core/common/error/failures.dart';
import '../../domain/repositories/i_download_e_book_repository.dart';
import '../datasource/i_download_e_book_datasource.dart';

class DownloadEBookRepositoryImpl implements IDownloadEBookRepository {
  final IDownloadEBookDatasource _iDownloadEBookRepository;

  DownloadEBookRepositoryImpl(this._iDownloadEBookRepository);

  @override
  Future<Either<Failure, String>> downloadEbook(String ebookUrl) async {
    try {
      final result = await _iDownloadEBookRepository.downloadEbook(ebookUrl);
      return Right(result);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
