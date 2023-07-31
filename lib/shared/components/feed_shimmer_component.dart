import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_media/shared/components/list_tile_shimmer_component.dart';
import 'package:shimmer/shimmer.dart';

class FeedShimmerComponent extends StatelessWidget {
  const FeedShimmerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ListTileShimmerComponent(),
            Container(
              color: Colors.white,
              width: MediaQuery.sizeOf(context).width,
              height: 200.w,
            ),
            SizedBox(height: 5.w),
            Container(
              color: Colors.white,
              width: MediaQuery.sizeOf(context).width,
              height: 50.w,
            ),
            SizedBox(height: 5.w),
            Container(
              color: Colors.white,
              width: 100.w,
              height: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}
