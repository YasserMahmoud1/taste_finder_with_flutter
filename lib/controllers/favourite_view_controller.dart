import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taste_finder/models/restaurant_model.dart';

class FavouriteViewController extends GetxController {
  List<RestaurantModel> restaurants = [];
  bool isLoading = false;

  @override
  void onInit() {
    getFavourite();
    super.onInit();
  }

  getFavourite() async {
    isLoading = true;
    update();
    List<dynamic> usersFav = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((user) => user.get("Favorites"));

    if (usersFav.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("Restaurants")
          .where(FieldPath.documentId,
              whereIn: usersFav) // Use FieldPath.documentId
          .get()
          .then((res) {
        restaurants = res.docs
            .map<RestaurantModel>((restaurant) =>
                RestaurantModel.fromJSON(restaurant.data(), restaurant.id))
            .toList();
      });
    } else {
      restaurants = [];
    }
    isLoading = false;
    update();
  }

  addRestaurant(RestaurantModel restaurant) {}

  removeRestaurant(RestaurantModel restaurant) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'Favorites': FieldValue.arrayRemove([restaurant.id]),
    });
    restaurants.removeWhere((res) => res.id == restaurant.id);
    getFavourite();
  }
}