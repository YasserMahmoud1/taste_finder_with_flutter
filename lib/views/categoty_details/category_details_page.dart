import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_details_controller.dart';
import 'package:taste_finder/controllers/theme_controller.dart';
import 'package:taste_finder/views/widgets/restaurant_card.dart';

class CategoryDetailsPage extends StatelessWidget {
  CategoryDetailsPage({super.key});

  final arguments = Get.arguments as Map<String, dynamic>;
  final controller = Get.put(CategoryDetailsController());
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:
                themeController.isDark.value ? Colors.black : Colors.white,
            title: Text(
              arguments["name"],
              style: TextStyle(
                color:
                    themeController.isDark.value ? Colors.white : Colors.black,
              ),
            ),
            leading: IconButton(
              tooltip: "Back",
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back_rounded),
              color: themeController.isDark.value ? Colors.white : Colors.black,
            ),
          ),
          body: GetBuilder<CategoryDetailsController>(
            builder: (c) => controller.isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16),
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) => RestaurantCard(
                      isNearBy: false,
                          isFav: false,
                          restaurant: controller.restaurants[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      itemCount: controller.restaurants.length,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
