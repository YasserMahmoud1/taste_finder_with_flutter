class RestaurantModel {
  final String id;
  final String name;

  final List<String> categories;
  final List<String> menu;
  final List<String> phoneNumbers;
  final String facebookLink;
  final String imageLink;
  final int likes;
  final String location;
  final String arabicName;
  double? distance;

  RestaurantModel(
    this.id,
    this.name,
    this.categories,
    this.menu,
    this.phoneNumbers,
    this.facebookLink,
    this.imageLink,
    this.likes,
    this.location,
    this.arabicName,
  );

  factory RestaurantModel.fromJSON(Map<String, dynamic> json, String rID) {
    return RestaurantModel(
      rID,
      json["Name"],
      List<String>.from(json["Categories"]),
      List<String>.from(json["Menu"]),
      List<String>.from(json["PhoneNumbers"]),
      // .toString().split(",").toList(),
      // json["Menu"].toString().split(",").toList(),
      // json["PhoneNumbers"].toString().split(",").toList(),
      json["FacebookLink"],
      json["ImageURL"],
      json["Likes"] as int,
      json["Location"],
      json["ArabicName"],
    );
  }

  setDistance(double newDistance) => distance = newDistance;
}
