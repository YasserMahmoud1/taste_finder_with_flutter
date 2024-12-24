import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/favourite_view_controller.dart';
import '../models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({super.key, required this.restaurant, required this.isFav});

  final bool isFav;
  final RestaurantModel restaurant;
  final FavouriteViewController controller = Get.put(FavouriteViewController());

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey[300],
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
                  Gap(8),
                  Text(
                    restaurant.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.black),
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
                    color: Theme.of(context).primaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
