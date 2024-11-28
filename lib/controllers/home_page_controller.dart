import 'package:get/get.dart';
import 'package:taste_finder/views/categories_view.dart';
import 'package:taste_finder/views/favourite_view.dart';
import 'package:taste_finder/views/nearby_view.dart';
import 'package:taste_finder/views/search_view.dart';

class HomePageController extends GetxController{
  final viewsList = [
    CategoriesView(),
    SearchView(),
    FavouriteView(),
    NearbyView(),
  ];
  var viewIndex = 0.obs;

  changeView(int newIndex){
    viewIndex.value = newIndex;
  }
}