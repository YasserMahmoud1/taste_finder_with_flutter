import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taste_finder/models/restaurant_model.dart';

class CategoryViewController extends GetxController {
  bool isLoading = false;
  List<RestaurantModel> topRestaurants = [];
  List<RestaurantModel> restaurants = [];
  String name = "";
  @override
  void onInit() {
    getDate();
    super.onInit();
  }

  getDate() async {
    isLoading = true;
    update();
    await getName();
    await getTopPicked();
    await getAllRestaurants();
    isLoading = false;
    update();
  }

  Future<void> getAllRestaurants() async {
    await FirebaseFirestore.instance
        .collection("Restaurants")
        .get()
        .then((res) {
      restaurants = res.docs
          .map<RestaurantModel>((restaurant) =>
              RestaurantModel.fromJSON(restaurant.data(), restaurant.id))
          .toList();
    });
    update();
  }

  Future<void> getTopPicked() async {
    topRestaurants =  await FirebaseFirestore.instance
        .collection("Restaurants")
        .orderBy("Likes", descending: true)
        .limit(5)
        .get()
        .then((res) =>
      res.docs
          .map<RestaurantModel>((restaurant) =>
              RestaurantModel.fromJSON(restaurant.data(), restaurant.id))
          .toList()
    );   
    update();
  }

  Future<void> getName() async {
    name = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((res) => res.get("Name"));
    update();
  }
}
