import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListTileShimmerComponent extends StatelessWidget {
  const ListTileShimmerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListTile(
        leading: const CircleAvatar(),
        title: Container(
          height: 12.0,
          color: Colors.white,
        ),
        subtitle: Container(
          height: 12.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
