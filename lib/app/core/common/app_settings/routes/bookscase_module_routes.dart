class BookscaseModuleRoutes {
  static String bookscaseMain = '/';
  static String bookscaseEbook = '/ebook-page/';
  static String bookscaseModule = '/bookscase-module/';

  static String subRoute(String route) {
    route = '/bookscase-module/${route.replaceFirst('/', '')}';
    return route;
  }
}
