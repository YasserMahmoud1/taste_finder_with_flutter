import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../models/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({super.key, required this.restaurant});

  final RestaurantModel restaurant;

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
        ),
      ),
    );
  }
}
