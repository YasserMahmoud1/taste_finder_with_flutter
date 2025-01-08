import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/models/restaurant_model.dart';

class TopPickedRestaurantItem extends StatelessWidget {
  const TopPickedRestaurantItem({super.key, required this.restaurantModel});

  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: () {
        Get.toNamed("/restaurantDetails",
            arguments: {"restaurant": restaurantModel});
      },
      child: SizedBox(
        height: 130,
        width: 200,
        child: Column(
          children: [
            Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    restaurantModel.imageLink,
                  ),
                  fit: BoxFit.values[2],
                ),
              ),
              height: 100,
              width: 200,
            ),
            Ink(
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(24))),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    restaurantModel.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        restaurantModel.likes.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// DONE: No more edits
