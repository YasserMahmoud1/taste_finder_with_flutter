import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/favourite_view_controller.dart';
import 'package:taste_finder/views/restaurant_card.dart';

class FavouriteView extends StatelessWidget {
  FavouriteView({super.key});

  final FavouriteViewController controller = Get.put(FavouriteViewController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouriteViewController>(
      builder: (c) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Favourite",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Gap(8),
              if (controller.restaurants.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      "No Favorites added yet\nFind some of your Favorite Restaurants",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (controller.restaurants.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => RestaurantCard(
                      restaurant: controller.restaurants[index],
                      isFav: true,
                    ),
                    separatorBuilder: (context, index) => Gap(16),
                    itemCount: controller.restaurants.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
