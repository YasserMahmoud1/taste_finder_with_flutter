import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_view_controller.dart';
import 'package:taste_finder/views/categories_view/top_picked_restaurant_item.dart';

class CategoriesViewTopPickedPart extends StatelessWidget {
  const CategoriesViewTopPickedPart({
    super.key,
    required this.controller,
  });

  final CategoryViewController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryViewController>(
      builder: (c) => Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "topPicked".tr,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          TopPickedRestaurants(controller: controller),
        ],
      ),
    );
  }
}

class TopPickedRestaurants extends StatelessWidget {
  const TopPickedRestaurants({
    super.key,
    required this.controller,
  });

  final CategoryViewController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // NOTE: Try to do something to remove the hard code
      height: 130,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 16),
            for (var i = 0; i < 5; i++)
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 8),
                child: TopPickedRestaurantItem(
                    restaurantModel: controller.topRestaurants[i]),
              ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
