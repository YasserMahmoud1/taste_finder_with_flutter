import 'package:get/get.dart';
import 'package:taste_finder/services/shared_pref_service.dart';

class SettingsController extends GetxController {
  String theme = SharedPrefService.getThemeString();
  String language = SharedPrefService.getLocaleCode();

  void changeTheme(String newTheme) {
    theme = newTheme;
    update();
  }

  void changeLanguage(String newLanguage) {
    language = newLanguage;
    update();
  }
}
