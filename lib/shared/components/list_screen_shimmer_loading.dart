import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListScreenShimmerComponent extends StatelessWidget {
  final Widget featureShimmerComponent;
  const ListScreenShimmerComponent(
      {super.key, required this.featureShimmerComponent});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 20,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) => featureShimmerComponent,
      ),
    );
  }
}
