import 'package:flutter/material.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/feature/feed/feed_notifier.dart';
import 'package:flutter_social_media/shared/components/feed_component.dart';
import 'package:flutter_social_media/shared/components/feed_shimmer_component.dart';
import 'package:flutter_social_media/shared/components/list_screen_shimmer_loading.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<FeedNotifier>().load();
      _scrollController.addListener(
          () => context.read<FeedNotifier>().scrollListener(_scrollController));
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseDataEntity = context.watch<FeedNotifier>().baseDataEntity;
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => context.read<FeedNotifier>().reload(),
      child: baseDataEntity.when(
        data: (snapshot) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.listData!.length + 1,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              if (index == snapshot.listData!.length) {
                if (snapshot.isLastPage) {
                  return const SizedBox.shrink();
                } else {
                  return const FeedShimmerComponent();
                }
              }

              final feedData = snapshot.listData![index];
              return FeedComponent(feedData: feedData);
            },
          );
        },
        error: (error) => Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(error.stateDescription),
          ),
        ),
        loading: () => const ListScreenShimmerComponent(
              featureShimmerComponent: FeedShimmerComponent()),
      ),
    );
  }
}
