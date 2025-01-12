import 'package:get/get.dart';
import 'package:taste_finder/services/shared_pref_service.dart';

class SettingsController extends GetxController {
  late String theme;
  late String language;

  @override
  void onInit() {
    theme = SharedPrefService.getThemeString();
    language = SharedPrefService.getLocaleCode();
        super.onInit();

  }

  void changeTheme(String newTheme) {
    theme = newTheme;
    update();
  }

  void changeLanguage(String newLanguage) {
    language = newLanguage;
    update();
  }
}
