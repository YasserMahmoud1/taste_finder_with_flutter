import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_view_controller.dart';
import 'package:taste_finder/controllers/theme_controller.dart';
import 'package:taste_finder/services/shared_pref_service.dart';

class CategoriesViewSearchWidget extends StatelessWidget {
  CategoriesViewSearchWidget({
    super.key,
    required this.controller,
  });

  final CategoryViewController controller;
  final SearchController searchController = SearchController();
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SearchAnchor.bar(
          searchController: searchController,
          barLeading: Icon(Icons.search,
              color:
                  themeController.isDark.value ? Colors.white : Colors.black),
          viewLeading: IconButton(
            tooltip: "Back",
            icon: Icon(
              Icons.arrow_back,
              color: themeController.isDark.value ? Colors.white : Colors.black,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          viewTrailing: [
            IconButton(
              tooltip: "Clear Text",
              icon: Icon(
                Icons.close,
                color:
                    themeController.isDark.value ? Colors.white : Colors.black,
              ),
              onPressed: () {
                searchController.clear();
              },
            ),
          ],
          viewBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
          suggestionsBuilder:
              (BuildContext context, SearchController sController) {
            final code = SharedPrefService.getLocaleCode();
            return controller.restaurants
                .where((res) => ((code == "en" ||
                            (code == "sys" &&
                                Get.deviceLocale!.languageCode == "en"))
                        ? res.name
                        : res.arabicName)
                    .toLowerCase()
                    .contains(sController.value.text.toLowerCase()))
                .map(
                  (filtered) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(filtered.imageLink),
                    ),
                    title: Text(
                      (code == "en" ||
                              (code == "sys" &&
                                  Get.deviceLocale!.languageCode == "en"))
                          ? filtered.name
                          : filtered.arabicName,
                      style: TextStyle(
                          color: themeController.isDark.value
                              ? Colors.white
                              : Colors.black),
                    ),
                    onTap: () {
                      Get.toNamed("/restaurantDetails",
                          arguments: {"restaurant": filtered});
                    },
                  ),
                );
          },
          barHintText: "search".tr,
        ),
      );
    });
  }
}
