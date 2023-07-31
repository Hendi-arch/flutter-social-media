import 'package:flutter/material.dart';

class UserShimmerComponent extends StatelessWidget {
  const UserShimmerComponent({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
