import 'package:flutter/material.dart';
import 'package:taste_finder/models/restaurant_model.dart';

class TopPickedRestaurantItem extends StatelessWidget {
  const TopPickedRestaurantItem({super.key, required this.restaurantModel});

  final RestaurantModel restaurantModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 200,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        // color: Colors.black,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 200,
            child: Image.network(
              restaurantModel.imageLink,
              fit: BoxFit.values[2],
            ),
          ),
          Container(
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: 16),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  restaurantModel.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      restaurantModel.likes.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 16,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),

      // child: Container(
      //   decoration: BoxDecoration(
      //     gradient: LinearGradient(
      //         colors: [Colors.transparent, Colors.transparent, Colors.black],
      //         begin: Alignment.topCenter,
      //         end: Alignment.bottomCenter,
      //     ),
      //   ),
      //   child: Align(
      //     alignment: Alignment.bottomCenter,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      //       child: Row(children: [
      //         Text("Afandina",style: TextStyle(color: Colros.),),
      //         Row(
      //           children: [Text("20"), Icon(Icons.favorite)],
      //         )
      //       ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
      //     ),
      //   ),
      // ),
    );
  }
}
