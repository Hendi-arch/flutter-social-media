import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:intl/intl.dart';

class FeedComponent extends StatelessWidget {
  final PostEntity feedData;

  const FeedComponent({super.key, required this.feedData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(feedData.owner.picture),
            ),
            title:
                Text('${feedData.owner.firstName} ${feedData.owner.lastName}'),
            subtitle: Text(DateFormat('dd MMMM yyyy HH:mm:ss')
                .format(feedData.publishDate!)),
          ),
          Image.network(
            feedData.image,
            width: MediaQuery.sizeOf(context).width,
            height: 200.w,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 5.w),
          Wrap(
            direction: Axis.horizontal,
            children: feedData.tags
                .map((e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5).w,
                      child: Chip(
                        label: Text(e),
                      ),
                    ))
                .toList(),
          ),
          SizedBox(height: 5.w),
          Text(feedData.text),
          SizedBox(height: 5.w),
          Text(
            '${feedData.likes.toString()} Likes',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
