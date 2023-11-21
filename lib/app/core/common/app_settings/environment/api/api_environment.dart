import 'api_environment_type.dart';

class ApiEnvironment {
  static const ApiEnvironmentType apiPointer = ApiEnvironmentType.HOMOLOG;

  static Map<String, dynamic> apiSettings() {
    late String baseURL;

    switch (apiPointer) {
      case ApiEnvironmentType.HOMOLOG:
        baseURL = 'https://escribo.com';
        break;
      case ApiEnvironmentType.PROD:
        baseURL = 'https://escribo.com';
        break;
    }

    return {
      'baseURL': baseURL,
      'books': '$baseURL/books.json',
    };
  }
}
