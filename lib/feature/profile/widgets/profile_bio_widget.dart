import 'package:flutter/material.dart';

class ProfileBioWidget extends StatelessWidget {
  final String title;
  final String? value;

  const ProfileBioWidget({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: RichText(
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        text: TextSpan(
          text: '$title : ',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: value ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
