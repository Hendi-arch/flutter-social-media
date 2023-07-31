import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerComponent extends StatelessWidget {
  const ProfileShimmerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 100.r,
              width: 100.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(),
              ),
            ),
          ),
          SizedBox(height: 10.w),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 12.0,
              width: 200,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10.w),
          Container(
            height: 12.0,
            width: 100,
            color: Colors.white,
          ),
          SizedBox(height: 10.w),
          Container(
            height: 12.0,
            width: 80,
            color: Colors.white,
          ),
          SizedBox(height: 10.w),
          Container(
            height: 12.0,
            width: 50,
            color: Colors.white,
          ),
          SizedBox(height: 10.w),
          Container(
            height: 12.0,
            width: 150,
            color: Colors.white,
          ),
          SizedBox(height: 10.w),
          Container(
            height: 12.0,
            width: 300,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
