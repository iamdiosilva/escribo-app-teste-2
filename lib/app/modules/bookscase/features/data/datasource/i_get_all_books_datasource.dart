import '../models/e_book_model.dart';

abstract class IGetAllBooksDatasource {
  Future<List<EBookModel>> getAllBooks();
}
