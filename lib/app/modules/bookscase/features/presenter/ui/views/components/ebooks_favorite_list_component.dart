import 'package:flutter/material.dart';

import '../../../controllers/bookscase_home_controller.dart';

class EbooksFavoriteListComponents extends StatelessWidget {
  final BookscaseHomeController controller;
  final Orientation orientation;
  const EbooksFavoriteListComponents({
    super.key,
    required this.orientation,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.eBookFavoritesList,
      builder: (context, books, child) {
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: books.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.6,
            crossAxisCount: (orientation == Orientation.portrait) ? 2 : 4,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () async {
              await controller.downloadEbook(books[index].downloadUrl);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  width: 0.1,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 92,
                          height: 128,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                books[index].coverUrl,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          books[index].title,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          books[index].author,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.eBookFavoritesList,
                      builder: (context, eBookFavoritesList, child) =>
                          Positioned(
                        right:
                            (orientation == Orientation.portrait) ? -10 : -10,
                        top: -10,
                        child: IconButton(
                          onPressed: () {
                            controller.addRemoveFavorite(books[index]);
                          },
                          color: Theme.of(context).primaryColor,
                          icon: Icon(
                            size: 32,
                            (eBookFavoritesList.any(
                                    (element) => element.id == books[index].id))
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
