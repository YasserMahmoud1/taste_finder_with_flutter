import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:taste_finder/models/restaurant_model.dart';

class CategoryDetailsController extends GetxController {
  var isLoading = false;
  late List<RestaurantModel> restaurants;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>;
    final id = args["id"];
    fetchData(id);
  }

  fetchData(String id) async {
    isLoading = true;
    update();
    await FirebaseFirestore.instance
        .collection("Restaurants")
        .where("Categories", arrayContains: id)
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
