import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/favorite_view_controller.dart';
import 'package:taste_finder/views/widgets/restaurant_card.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({super.key});

  final FavoriteViewController controller = Get.put(FavoriteViewController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteViewController>(
      builder: (c) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "favorite".tr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (controller.restaurants.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      "noFavorite".tr,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (controller.restaurants.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => RestaurantCard(
                      isNearBy: false,
                      restaurant: controller.restaurants[index],
                      isFav: true,
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 8),
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
