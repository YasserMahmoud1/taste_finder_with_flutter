import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_view_controller.dart';
import 'package:taste_finder/views/top_picked_restaurant_item.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({super.key});

  final categoriesList = [
    {"Name": "Burger", "ID": "Burger", "Image": "Burger.png"},
    {"Name": "Shawerma", "ID": "Shawerma", "Image": "Shawerma.png"},
    {"Name": "Dessert", "ID": "Dessert", "Image": "Dessert.png"},
    {"Name": "Pasta", "ID": "Pasta", "Image": "Pasta.png"},
    {"Name": "Sea Food", "ID": "SeaFood", "Image": "SeaFood.png"},
    {"Name": "Café", "ID": "Cafe", "Image": "Cafe.png"},
    {"Name": "Pizza", "ID": "Pizza", "Image": "Pizza.png"},
    {
      "Name": "Fried Chicken",
      "ID": "FriedChicken",
      "Image": "FriedChicken.png"
    },
    {"Name": "Others", "ID": "Others", "Image": "Other.png"},
  ];

  // the height of the screen
  // 58 size of the bottom nav bar
  // 16 top padding
  // 48 size of the row
  // 16 gap
  // 34 top picked
  // 8 gap
  // 130
  // 16 gap
  // 34 cat
  // 8 gap
  // sum is 58 + 16 + 48 + 16 + 34 + 8 + 130 + 16 + 34 + 8
  // is 392[
  final CategoryViewController controller = Get.put(CategoryViewController());

  @override
  Widget build(BuildContext context) {
    final boxHeight = (MediaQuery.of(context).size.height - 400) / 3;
    final boxWidth = (MediaQuery.of(context).size.width - 96) / 3;
    final imageSize = (MediaQuery.of(context).size.height - 472) / 3;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: GetBuilder<CategoryViewController>(
          builder: (c) => controller.isLoading == true
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Text("Hello, Yasser"),
                          FilledButton(
                              onPressed: () {}, child: Text("Sign Out")),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Top Picked Restaurants",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gap(8),
                    SizedBox(
                      height: 130,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Gap(16),
                            for (var i = 0; i < 5; i++)
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 8),
                                child: TopPickedRestaurantItem(
                                    restaurantModel: controller.restaurants[i]),
                              ),
                            Gap(8),
                          ],
                        ),
                      ),
                    ),
                    Gap(16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gap(8),
                    Expanded(
                      child: Center(
                        child: Wrap(
                          children: [
                            for (var i in categoriesList)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(
                                      "categoryDetails",
                                      arguments: {
                                        "name": i["Name"],
                                        "id": i["ID"],
                                      },
                                    );
                                  },
                                  child: SizedBox(
                                    height: boxHeight,
                                    width: boxWidth,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          "assets/images/${i["Image"]!}",
                                          height: imageSize,
                                          width: imageSize,
                                        ),
                                        Gap(4),
                                        Text(i["Name"]!),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Gap(8),
                  ],
                ),
        ),
      ),
    );
  }
}
