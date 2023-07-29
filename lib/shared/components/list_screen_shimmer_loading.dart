import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListScreenShimmerComponent extends StatelessWidget {
  const ListScreenShimmerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(),
            title: Container(
              height: 12.0,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 12.0,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }
}
