import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_view_controller.dart';
import 'package:taste_finder/controllers/nearby_controller.dart';
import 'package:taste_finder/views/widgets/restaurant_card.dart';

class NearbyView extends StatelessWidget {
  NearbyView({super.key});
  final categoryController = Get.find<CategoryViewController>();
  final nearbyController = Get.put(NearbyController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyController>(
      builder: (c) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            spacing: 24,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "nearby".tr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (!nearbyController.locationEnabled)
                Expanded(child: Center(child: Text("noLocationEnabled".tr))),
              if (!nearbyController.locationPermission)
                Expanded(child: Center(child: Text("permissionDenied".tr))),
              if (nearbyController.locationPermission &&
                  nearbyController.locationEnabled)
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => RestaurantCard(
                      isNearBy: true,
                      restaurant: categoryController.restaurants[index],
                      isFav: false,
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemCount: categoryController.restaurants.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
