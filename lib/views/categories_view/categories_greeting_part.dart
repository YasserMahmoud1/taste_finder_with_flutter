
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taste_finder/controllers/category_view_controller.dart';

class CategoriesViewGreetingPart extends StatelessWidget {
  const CategoriesViewGreetingPart({
    super.key,
    required this.controller,
  });

  final CategoryViewController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text("${"hello".tr}, ${controller.name}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}
