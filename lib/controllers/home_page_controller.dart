import 'package:get/get.dart';
import 'package:taste_finder/views/categories_view/categories_view.dart';
import 'package:taste_finder/views/favorite/favorite_view.dart';
import 'package:taste_finder/views/nearby/nearby_view.dart';

import '../views/settings/setting_view.dart';

class HomePageController extends GetxController {
  final viewsList = [
    CategoriesView(),
    FavoriteView(),
    NearbyView(),
    SettingView(),
  ];
  var viewIndex = 0.obs;

  changeView(int newIndex) {
    viewIndex.value = newIndex;
  }
}
