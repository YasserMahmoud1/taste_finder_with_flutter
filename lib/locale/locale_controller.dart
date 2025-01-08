import 'dart:ui';

import 'package:get/get.dart';
import 'package:taste_finder/services/shared_pref_service.dart';

class LocaleController extends GetxController {
  final Locale initLang = Locale(SharedPrefService.getLocaleCode() == "sys"
      ? Get.deviceLocale!.languageCode
      : SharedPrefService.getLocaleCode());

  void changeLang(String codeLang) {
    SharedPrefService.setLocaleCode(codeLang);
    if (codeLang == "sys") {
      codeLang = Get.deviceLocale!.languageCode;
    }
    Locale locale = Locale(codeLang);
    Get.updateLocale(locale);
  }
}
