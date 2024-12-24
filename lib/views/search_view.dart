import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/search_page_controller.dart';
import 'package:taste_finder/views/restaurant_card.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final editingController = TextEditingController();
  final controller = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPageController>(
      builder: (c) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Gap(8),
              TextFormField(
                controller: editingController,
                onChanged: (q) {
                  controller.search(q);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: "Search",
                    suffixIcon: Icon(Icons.search)),
              ),
              Gap(16),
              if (controller.isLoading == true)
                Expanded(child: Center(child: CircularProgressIndicator()))
              else if (controller.restaurants.isEmpty)
                Expanded(child: Center(child: Text("Restaurant is not found")))
              else if (editingController.text.isEmpty)
                Expanded(
                    child: Center(child: Text("Search to find your Taste!")))
              else
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => RestaurantCard(
                        isFav: false,
                        restaurant: controller.restaurants[index]),
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
