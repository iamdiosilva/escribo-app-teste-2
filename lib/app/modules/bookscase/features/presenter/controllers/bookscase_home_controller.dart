import 'dart:convert';
import 'dart:developer';

import 'package:escribo_app_teste_2/app/modules/bookscase/features/domain/usecases/download_e_book_usecase.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../../../../../core/common/micro_state_management/controllers/base_controller.dart';
import '../../../../../core/common/usecase/no_params.dart';
import '../../data/models/e_book_model.dart';
import '../../domain/usecases/get_all_books_usecase.dart';

class BookscaseHomeController extends BaseController {
  final GetAllBooksUsecase _getAllBooksUsecase;
  final DownloadEBookUsecase _downloadEBookUsecase;

  late PageController pageController;

  ValueNotifier<int> pageIndex = ValueNotifier<int>(0);
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<bool> isError = ValueNotifier<bool>(false);

  String filePath = '';

  ValueNotifier<List<EBookModel>> eBookFavoritesList = ValueNotifier([]);
  ValueNotifier<List<EBookModel>> eBooklist = ValueNotifier([]);

  BookscaseHomeController(this._getAllBooksUsecase, this._downloadEBookUsecase);

  @override
  void init() {
    pageController = PageController(initialPage: pageIndex.value);

    getAllBooks();
    getFavoritesEbooks();
  }

  changePage(int page) {
    pageIndex.value = page;
    pageController.animateToPage(
      page,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 150),
    );
  }

  getAllBooks() async {
    isLoading.value = true;
    isError.value = false;
    final result = await _getAllBooksUsecase.call(NoParams());

    result.fold((l) {
      isError.value = true;
      isLoading.value = false;
    }, (r) {
      isError.value = false;
      isLoading.value = false;

      eBooklist.value = List.from(r as List<EBookModel>);
    });
  }

  downloadEbook(String ebookUrl) async {
    isLoading.value = true;

    filePath = '';
    final result = await _downloadEBookUsecase.call(ebookUrl);

    result.fold((l) => isLoading.value = false, (r) {
      filePath = r;
      VocsyEpub.setConfig(
        identifier: "iosBook",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
        nightMode: true,
      );

      // get current locator
      VocsyEpub.locatorStream.listen((locator) {
        log('LOCATOR: $locator');
      });
      VocsyEpub.open(
        filePath,
        lastLocation: EpubLocator.fromJson(
          {
            "bookId": "2239",
            "href": "/OEBPS/ch06.xhtml",
            "created": 1539934158390,
            "locations": {
              "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)",
            }
          },
        ),
      );
      isLoading.value = false;
    });
  }

  addRemoveFavorite(EBookModel ebook) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<EBookModel> favoriteList = eBookFavoritesList.value;

    if (favoriteList.any((element) => element.id == ebook.id)) {
      favoriteList.removeWhere((element) => element.id == ebook.id);
    } else {
      favoriteList.add(ebook);
    }

    final List<Map<String, dynamic>> favoritesMap =
        favoriteList.map((e) => e.toJson()).toList();

    final json = jsonEncode(favoritesMap);

    await prefs.setString('favorites', json);

    eBookFavoritesList.value = List.from(favoriteList);
    await getFavoritesEbooks();
  }

  getFavoritesEbooks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? favoritesJson = prefs.getString('favorites');

    if (favoritesJson != null) {
      final List json = jsonDecode(favoritesJson);

      final favoriteListFromJson =
          json.map((e) => EBookModel.fromJson(e)).toList();

      eBookFavoritesList.value = List.from(favoriteListFromJson);
    }
  }
}
