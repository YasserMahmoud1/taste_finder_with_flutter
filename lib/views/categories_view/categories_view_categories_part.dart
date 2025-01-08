
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesViewCategoriesPart extends StatelessWidget {
  const CategoriesViewCategoriesPart({
    super.key,
    required this.categoriesList,
  });

  final List<Map<String, String>> categoriesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "categories".tr,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Categories(categoriesList: categoriesList),
      ],
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    super.key,
    required this.categoriesList,
  });
  // 24 Safe Area
  // 16 Top Padding
  // 31 Greeting
  // 16 spacing
  // 56 Search
  // 16 spacing
  // 177 Top Picked
  // 16 spacing
  // 34 Categories text
  // 8 Container spacing
  // 66 Bottom Nav Bar
  // sum = 460

  // width = 6*16 = 96
  final List<Map<String, String>> categoriesList;
  @override
  Widget build(BuildContext context) {
    final boxHeight = (MediaQuery.of(context).size.height - 470);
    final boxWidth = (MediaQuery.of(context).size.width - 96);
    final imgSize = (MediaQuery.of(context).size.height - 550);
    return SizedBox(
      height: boxHeight,
      child: Wrap(
        children: [
          for (var i in categoriesList)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: () {
                  Get.toNamed(
                    "categoryDetails",
                    arguments: {
                      "name": "${i["Name"]}".tr,
                      "id": i["ID"],
                    },
                  );
                },
                child: SizedBox(
                  height: boxHeight / 3,
                  width: boxWidth / 3,
                  child: Column(
                    spacing: 4,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/${i["Image"]!}",
                        height: imgSize / 3,
                        width: imgSize / 3,
                      ),
                      Text("${i["Name"]}".tr),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
