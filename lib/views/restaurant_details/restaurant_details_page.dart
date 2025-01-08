import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:taste_finder/controllers/category_view_controller.dart';
import 'package:taste_finder/controllers/favorite_view_controller.dart';
import 'package:taste_finder/controllers/theme_controller.dart';
import 'package:taste_finder/models/restaurant_model.dart';
import 'package:taste_finder/services/shared_pref_service.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailsPage extends StatelessWidget {
  RestaurantDetailsPage({super.key});

  final RestaurantModel restaurant = Get.arguments["restaurant"];
  final themeController = Get.find<ThemeController>();
  final FavoriteViewController favController =
      Get.find<FavoriteViewController>();

  final categoriesController = Get.find<CategoryViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          (SharedPrefService.getLocaleCode() == "en" ||
                  (SharedPrefService.getLocaleCode() == "sys" &&
                      Get.deviceLocale!.languageCode == "en"))
              ? restaurant.name
              : restaurant.arabicName,
          style: TextStyle(
            color: themeController.isDark.value ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          tooltip: "Back",
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded),
          color: themeController.isDark.value ? Colors.white : Colors.black,
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Row(
                spacing: 16,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * .6 - 40,
                    width: MediaQuery.of(context).size.width * .6 - 40,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(restaurant.imageLink),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                              Colors.green.shade800,
                            )),
                            label: Text("Phone"),
                            onPressed: () {
                              launchUrl(Uri(
                                  scheme: "tel",
                                  path: restaurant.phoneNumbers.first));
                            },
                            icon: Icon(Icons.phone),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                              Colors.yellow.shade900,
                            )),
                            label: Text("Location"),
                            onPressed: () {
                              launchUrl(Uri.parse(restaurant.location));
                            },
                            icon: Icon(Icons.location_on),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                              Colors.blue,
                            )),
                            label: Text("Facebook"),
                            onPressed: () {
                              launchUrl(Uri.parse(restaurant.facebookLink));
                            },
                            icon: Image.asset(
                              "assets/images/facebook.png",
                              height: 24,
                              width: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              GetBuilder<FavoriteViewController>(
                builder: (c) => SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                          favController.isFavorite(restaurant.id)
                              ? Colors.grey.shade700
                              : Colors.purple),
                    ),
                    child: favController.isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator(color: Colors.white))
                        : Text(favController.isFavorite(restaurant.id)
                            ? "Remove Favorite"
                            : "Add to Favorite"),
                    onPressed: () async {
                      if (favController.isFavorite(restaurant.id)) {
                        await favController.removeRestaurant(restaurant);
                      } else {
                        await favController.addRestaurant(restaurant);
                      }
                      await categoriesController.getTopPicked();
                    },
                  ),
                ),
              ),
              Text(
                "${"menu".tr}: ",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              for (var i = 0; i < restaurant.menu.length; i++)
                InkWell(
                  onTap: () {
                    Get.toNamed("/photo_gallery", arguments: {
                      "photos": restaurant.menu,
                      "index": i,
                      "name": restaurant.name
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      restaurant.menu[i],
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child; // The image is fully loaded
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null, // Display progress if available
                          ),
                        );
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar(
      //       actions: [
      //         Container(
      //           margin: EdgeInsets.symmetric(horizontal: 8),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(50),
      //           ),
      //           child: IconButton(
      //             onPressed: () {},
      //             icon: Icon(Icons.favorite),
      //           ),
      //         )
      //       ],
      //       leading: Container(
      //         margin: EdgeInsets.symmetric(horizontal: 8),
      //         decoration: BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.circular(50),
      //         ),
      //         child: IconButton(
      //           onPressed: () {
      //             Get.back();
      //           },
      //           icon: Icon(Icons.arrow_back_rounded),
      //         ),
      //       ),
      //       expandedHeight: 250.0,
      //       // Initial height of the app bar
      //       pinned: true,
      //       // Keeps a portion of the app bar visible when scrolled
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Text(restaurant.name),
      //         background: Image.network(
      //           restaurant.imageLink, // Background image
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //     SliverList(
      //       delegate: SliverChildListDelegate(

      //       ),
      //     ),
      //     // The PhotoViewGallery is placed here, outside the SliverList
      //     // SliverToBoxAdapter(
      //     //   child: Container(
      //     //     height: 400, // You can adjust the height as needed
      //     //     child: PhotoViewGallery.builder(
      //     //       scrollPhysics: BouncingScrollPhysics(),
      //     //       scrollDirection: Axis.vertical,
      //     //       itemCount: restaurant.menu.length,
      //     //       builder: (context, index) => PhotoViewGalleryPageOptions(
      //     //         imageProvider: NetworkImage(restaurant.menu[index]),
      //     //         heroAttributes: PhotoViewHeroAttributes(
      //     //           tag: restaurant.menu[index],
      //     //         ),
      //     //       ),
      //     //       backgroundDecoration: BoxDecoration(
      //     //         color: Colors.black,
      //     //       ),
      //     //       pageController: PageController(),
      //     //     ),
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}

class FullScreenGallery extends StatefulWidget {
  const FullScreenGallery({super.key});

  @override
  State<FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late List<String> photos;
  late int index;
  late String name;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    photos = Get.arguments["photos"];
    index = Get.arguments["index"];
    name = Get.arguments["name"];

    _pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
      ),
      body: PhotoViewGallery.builder(
        enableRotation: true,
        pageController: _pageController,
        itemCount: photos.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(photos[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            heroAttributes: PhotoViewHeroAttributes(tag: photos[index]),
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(color: Colors.black),
      ),
    );
  }
}
