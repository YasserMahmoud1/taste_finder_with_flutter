import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/home_page_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageController control = Get.put(HomePageController());
    return GetX<HomePageController>(
      builder: (c) => Scaffold(
        body: control.viewsList[control.viewIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favourite"),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_pin), label: "Near By"),
          ],
          currentIndex: control.viewIndex.value,
          onTap: (index) {
            control.changeView(index);
          },
        ),
      ),
    );
  }
}
