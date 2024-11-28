import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:taste_finder/models/restaurant_model.dart';

class SearchPageController extends GetxController {
  List<RestaurantModel> restaurants = [];
  bool isLoading = false;

  search(String query) async {
    isLoading = true;
    update();
    await FirebaseFirestore.instance
        .collection("Restaurants")
        .orderBy("Name")
        .startAt([query])
        .endAt(['$query\uf8ff']) // Ensures matches that start with searchQuery
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
