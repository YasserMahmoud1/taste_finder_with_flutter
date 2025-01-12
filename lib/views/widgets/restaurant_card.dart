import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/theme_controller.dart';
import 'package:taste_finder/services/shared_pref_service.dart';

import '../../controllers/favorite_view_controller.dart';
import '../../models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard(
      {super.key,
      required this.restaurant,
      required this.isFav,
      required this.isNearBy});

  final bool isFav;
  final bool isNearBy;
  final RestaurantModel restaurant;
  final FavoriteViewController controller = Get.put(FavoriteViewController());
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color:
            themeController.isDark.value ? Colors.grey[850] : Colors.grey[300],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          Get.toNamed("/restaurantDetails",
              arguments: {"restaurant": restaurant});
        },
        child: Container(
          padding: EdgeInsets.all(8),
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(restaurant.imageLink),
                    radius: 50,
                  ),
                  SizedBox(width: 8),
                  Text(
                    (SharedPrefService.getLocaleCode() == "en" ||
                            (SharedPrefService.getLocaleCode() == "sys" &&
                                Get.deviceLocale!.languageCode == "en"))
                        ? restaurant.name
                        : restaurant.arabicName,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: themeController.isDark.value
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              if (isFav)
                IconButton(
                  onPressed: () {
                    controller.removeRestaurant(restaurant);
                  },
                  icon: Icon(
                    Icons.favorite,
                    size: 32,
                    color: Colors.deepOrangeAccent,
                  ),
                ),
              if (isNearBy) Text(_formatTheDistance(restaurant.distance ?? 0))
            ],
          ),
        ),
      ),
    );
  }

  String _formatTheDistance(double distance) {
    if (distance >= 1000) {
      final d = distance / 1000.0;
      return "${d.toStringAsFixed(2)} Km";
    } else {
      return "${distance.toStringAsFixed(2)} m";
    }
  }
}
