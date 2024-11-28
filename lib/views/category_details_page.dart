import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_details_controller.dart';
import 'package:taste_finder/views/restaurant_card.dart';

class CategoryDetailsPage extends StatelessWidget {
  CategoryDetailsPage({super.key});

  final arguments = Get.arguments as Map<String, dynamic>;
  final controller = Get.put(CategoryDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments["name"]),
      ),
      body: GetBuilder<CategoryDetailsController>(
        builder: (c) => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) => RestaurantCard(
                        restaurant: controller.restaurants[index]),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemCount: controller.restaurants.length),
              ),
      ),
    );
  }
}
