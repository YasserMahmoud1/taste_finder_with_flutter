import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_view_controller.dart';

class NearbyController extends GetxController with WidgetsBindingObserver {
  final CategoryViewController categoryController =
      Get.find<CategoryViewController>();
  bool locationEnabled = false;
  bool locationPermission = false;
  // late final List<RestaurantModel> nearByRestaurants;
  @override
  void onInit() async {
    // nearByRestaurants = categoryController.restaurants;
    WidgetsBinding.instance.addObserver(this);
    locationEnabled = await Geolocator.isLocationServiceEnabled();
    locationPermission = await _checkPermission();
    _calculateAllDistances();

    super.onInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<bool> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "Permission Required",
        "Location permission is permanently denied. Please enable it from the app settings.",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "Permission Denied",
          "Location permission is required to calculate distances.",
          snackPosition: SnackPosition.BOTTOM,
        );
        return false;
      }
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<void> _calculateAllDistances() async {
    try {
      Position currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      for (var res in categoryController.restaurants) {
        final coordinates = _extractCoordinates(res.location);
        double distance = Geolocator.distanceBetween(
          currentPosition.latitude,
          currentPosition.longitude,
          coordinates["latitude"] ?? 0,
          coordinates["longitude"] ?? 0,
        );
        res.setDistance(distance);
      }
      categoryController.restaurants
          .sort((a, b) => a.distance!.compareTo(b.distance!));

      update(); // Update the UI with the new distances
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to calculate distances: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _checkLocationServices();
    }
  }

  Future<void> _checkLocationServices() async {
    locationEnabled = await Geolocator.isLocationServiceEnabled();
    update();
  }

  Map<String, double> _extractCoordinates(String url) {
    final regex = RegExp(r'@(-?\d+\.\d+),(-?\d+\.\d+)');
    final match = regex.firstMatch(url);
    if (match != null && match.groupCount == 2) {
      double latitude = double.parse(match.group(1)!);
      double longitude = double.parse(match.group(2)!);
      return {'latitude': latitude, 'longitude': longitude};
    }
    return {'latitude': 0, 'longitude': 0};
  }
}
