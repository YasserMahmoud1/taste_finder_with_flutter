import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_view_controller.dart';
import 'package:taste_finder/views/categories_view/categories_search_part.dart';
import 'package:taste_finder/views/categories_view/categories_top_picked_part.dart';

import 'categories_greeting_part.dart';
import 'categories_view_categories_part.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({super.key});

  final categoriesList = [
    {"Name": "burger", "ID": "Burger", "Image": "Burger.png"},
    {"Name": "shawerma", "ID": "Shawerma", "Image": "Shawerma.png"},
    {"Name": "dessert", "ID": "Dessert", "Image": "Dessert.png"},
    {"Name": "pasta", "ID": "Pasta", "Image": "Pasta.png"},
    {"Name": "seaFood", "ID": "SeaFood", "Image": "SeaFood.png"},
    {"Name": "cafe", "ID": "Cafe", "Image": "Cafe.png"},
    {"Name": "pizza", "ID": "Pizza", "Image": "Pizza.png"},
    {"Name": "friedChicken", "ID": "FriedChicken", "Image": "FriedChicken.png"},
    {"Name": "others", "ID": "Others", "Image": "Other.png"},
  ];

  final CategoryViewController controller = Get.put(CategoryViewController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: GetBuilder<CategoryViewController>(
          builder: (c) => controller.isLoading == true
              ? Center(child: CircularProgressIndicator())
              : CategoriesViewContent(
                  controller: controller,
                  categoriesList: categoriesList,
                ),
        ),
      ),
    );
  }
}

class CategoriesViewContent extends StatelessWidget {
  const CategoriesViewContent({
    super.key,
    required this.controller,
    required this.categoriesList,
  });

  final CategoryViewController controller;
  final List<Map<String, String>> categoriesList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          CategoriesViewGreetingPart(controller: controller),
          CategoriesViewSearchWidget(controller: controller),
          CategoriesViewTopPickedPart(controller: controller),
          CategoriesViewCategoriesPart(categoriesList: categoriesList),
        ],
      ),
    );
  }
}

