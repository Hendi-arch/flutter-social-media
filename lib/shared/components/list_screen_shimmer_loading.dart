import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListScreenShimmerComponent extends StatelessWidget {
  final Widget featureShimmerComponent;
  final bool isUseSliverList;

  const ListScreenShimmerComponent({
    super.key,
    required this.featureShimmerComponent,
  }) : isUseSliverList = false;

  const ListScreenShimmerComponent.sliver({
    super.key,
    required this.featureShimmerComponent,
  }) : isUseSliverList = true;

  @override
  Widget build(BuildContext context) {
    if (isUseSliverList) {
      return SliverPadding(
        padding: const EdgeInsets.all(15),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: featureShimmerComponent,
            ),
            childCount: 20,
          ),
        ),
      );
    }

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
