import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:taste_finder/models/restaurant_model.dart';

class CategoryViewController extends GetxController {
  bool isLoading = false;
  late List<RestaurantModel> topRestaurants;
  late List<RestaurantModel> restaurants;

  @override
  void onInit() {
    getDate();
    super.onInit();
  }

  getDate() async {
    isLoading = true;
    update();
    await FirebaseFirestore.instance
        .collection("Restaurants")
        .orderBy("Likes", descending: true)
        .limit(5)
        .get()
        .then((res) {
      topRestaurants = res.docs
          .map<RestaurantModel>((restaurant) =>
              RestaurantModel.fromJSON(restaurant.data(), restaurant.id))
          .toList();
    });
    await FirebaseFirestore.instance
        .collection("Restaurants")
        .get()
        .then((res) {
      restaurants = res.docs
          .map<RestaurantModel>((restaurant) =>
              RestaurantModel.fromJSON(restaurant.data(), restaurant.id))
          .toList();
    });
    isLoading = false;
    update();
  }
}
