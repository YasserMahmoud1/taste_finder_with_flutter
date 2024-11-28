import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NearbyView extends StatelessWidget {
  const NearbyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Padding(
      padding: const EdgeInsets.fromLTRB(16,16,16,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Near By", style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
          Gap(8),
          Expanded(child: Center(child: Text("Enable Location to find near by restaurants"))),
        ],
      ),
    ),);
  }

}
