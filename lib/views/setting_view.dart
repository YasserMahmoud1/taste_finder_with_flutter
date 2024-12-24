import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String? theme = "themeSystem";
  String? language = "langSystem";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Theme",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          borderRadius: BorderRadius.circular(8),
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          value: theme,
                          items: [
                            DropdownMenuItem(
                              child: Text("Same as System"),
                              value: "themeSystem",
                            ),
                            DropdownMenuItem(
                              child: Text("Light Mood"),
                              value: "light",
                            ),
                            DropdownMenuItem(
                              child: Text("Dark Mood"),
                              value: "dark",
                            ),
                          ],
                          onChanged: (s) {
                            setState(() {
                              theme = s;
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Language",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          borderRadius: BorderRadius.circular(8),
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          value: language,
                          items: [
                            DropdownMenuItem(
                              child: Text("Same as System"),
                              value: "langSystem",
                            ),
                            DropdownMenuItem(
                              child: Text("Arabic"),
                              value: "arabic",
                            ),
                            DropdownMenuItem(
                              child: Text("English"),
                              value: "english",
                            ),
                          ],
                          onChanged: (s) {
                            setState(() {
                              language = s;
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gap(16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
                width: double.infinity,
                child: FilledButton(onPressed: () {}, child: Text("Logout"))),
          )
        ],
      ),
    );
  }
}
