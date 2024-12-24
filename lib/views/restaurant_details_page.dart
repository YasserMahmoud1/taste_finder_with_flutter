import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:taste_finder/models/restaurant_model.dart';

class RestaurantDetailsPage extends StatelessWidget {
  RestaurantDetailsPage({super.key});

  final RestaurantModel restaurant = Get.arguments["restaurant"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                ),
              )
            ],
            leading: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_rounded),
              ),
            ),
            expandedHeight: 250.0,
            // Initial height of the app bar
            pinned: true,
            // Keeps a portion of the app bar visible when scrolled
            flexibleSpace: FlexibleSpaceBar(
              title: Text(restaurant.name),
              background: Image.network(
                restaurant.imageLink, // Background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Text("facebook link"),
                Text("maps link"),
                Text("phone number"),
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
                      child: Image.network(restaurant.menu[i]),
                    ),
                  ),
              ],
            ),
          ),
          // The PhotoViewGallery is placed here, outside the SliverList
          // SliverToBoxAdapter(
          //   child: Container(
          //     height: 400, // You can adjust the height as needed
          //     child: PhotoViewGallery.builder(
          //       scrollPhysics: BouncingScrollPhysics(),
          //       scrollDirection: Axis.vertical,
          //       itemCount: restaurant.menu.length,
          //       builder: (context, index) => PhotoViewGalleryPageOptions(
          //         imageProvider: NetworkImage(restaurant.menu[index]),
          //         heroAttributes: PhotoViewHeroAttributes(
          //           tag: restaurant.menu[index],
          //         ),
          //       ),
          //       backgroundDecoration: BoxDecoration(
          //         color: Colors.black,
          //       ),
          //       pageController: PageController(),
          //     ),
          //   ),
          // ),
        ],
      ),
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
