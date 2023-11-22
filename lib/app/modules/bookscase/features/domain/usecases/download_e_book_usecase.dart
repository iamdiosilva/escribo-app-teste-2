import 'package:dartz/dartz.dart';

import '../../../../../core/common/error/failures.dart';
import '../../../../../core/common/usecase/i_future_usecase.dart';

import '../repositories/i_download_e_book_repository.dart';

class DownloadEBookUsecase implements IFutureUsecase<String, String> {
  DownloadEBookUsecase(this._iDownloadEBookRepository);
  final IDownloadEBookRepository _iDownloadEBookRepository;

  @override
  Future<Either<Failure, String>> call(String ebookUrl) {
    return _iDownloadEBookRepository.downloadEbook(ebookUrl);
  }
}
