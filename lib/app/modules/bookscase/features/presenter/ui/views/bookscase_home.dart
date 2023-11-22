import 'package:escribo_app_teste_2/app/modules/bookscase/features/presenter/ui/views/components/ebooks_favorite_list_component.dart';
import 'package:escribo_app_teste_2/app/modules/bookscase/features/presenter/ui/views/components/ebooks_list_component.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/common/app_settings/design_system/widgets/common_elevated_button_ds.dart';
import '../../../../../../core/common/app_settings/design_system/widgets/common_loading_page_ds.dart';
import '../../../../../../core/common/micro_state_management/state/page_state.dart';
import '../../controllers/bookscase_home_controller.dart';

class BookscaseHome extends StatefulWidget {
  const BookscaseHome({super.key});

  @override
  State<BookscaseHome> createState() => _BookscaseHomeState();
}

class _BookscaseHomeState
    extends PageState<BookscaseHome, BookscaseHomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CommonLoadingPageDS(
        isLoading: controller.isLoading,
        child: OrientationBuilder(
          builder: (context, orientation) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SafeArea(
                  child: ValueListenableBuilder(
                    valueListenable: controller.pageIndex,
                    builder: (context, pageIndex, child) => Row(
                      children: [
                        CommonElevatedButtonDS(
                          title: 'Livros',
                          onPressed: (pageIndex == 1)
                              ? () {
                                  controller.changePage(pageIndex - 1);
                                }
                              : null,
                        ),
                        const SizedBox(width: 4),
                        CommonElevatedButtonDS(
                          onPressed: (pageIndex == 0)
                              ? () {
                                  controller.changePage(pageIndex + 1);
                                }
                              : null,
                          title: 'Favoritos',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: controller.pageController,
                      scrollDirection: (orientation == Orientation.portrait)
                          ? Axis.horizontal
                          : Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (context, index) => ValueListenableBuilder(
                          valueListenable: controller.isError,
                          builder: (context, isError, child) {
                            return (isError)
                                ? Center(
                                    child: CommonElevatedButtonDS(
                                      title: 'Reload',
                                      onPressed: () async =>
                                          controller.getAllBooks(),
                                    ),
                                  )
                                : (controller.pageIndex.value == 0)
                                    ? EbooksListComponents(
                                        controller: controller,
                                        orientation: orientation,
                                      )
                                    : EbooksFavoriteListComponents(
                                        controller: controller,
                                        orientation: orientation,
                                      );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
