import '../../../../../core/common/app_settings/environment/api/api_environment.dart';
import '../../../../../core/common/error/exceptions.dart';
import '../../../../../core/common/http_client/enum/request_type.dart';
import '../../../../../core/common/http_client/i_http/i_http_client.dart';
import '../datasource/i_get_all_books_datasource.dart';
import '../models/e_book_model.dart';

class GetAllBooksDatasourceImpl implements IGetAllBooksDatasource {
  final IHttpClient iHttpClient;

  GetAllBooksDatasourceImpl(this.iHttpClient);

  @override
  Future<List<EBookModel>> getAllBooks() async {
    final response = await iHttpClient.request(
      type: RequestType.GET,
      path: ApiEnvironment.apiSettings()['books'],
    );

    if (response.statusCode == 200) {
      final List eBooksListData = response.data;
      final List<EBookModel> ebooks =
          eBooksListData.map((e) => EBookModel.fromJson(e)).toList();
      return ebooks;
    } else {
      throw const ServerException('Something went wrong');
    }
  }
}
