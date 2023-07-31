import 'package:flutter/material.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/feature/home/home_notifier.dart';
import 'package:flutter_social_media/shared/components/list_screen_shimmer_loading.dart';
import 'package:flutter_social_media/shared/components/list_tile_shimmer_component.dart';
import 'package:flutter_social_media/shared/components/user_shimmer_component.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<HomeNotifier>().load();
      _scrollController.addListener(
          () => context.read<HomeNotifier>().scrollListener(_scrollController));
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseDataEntity = context.watch<HomeNotifier>().baseDataEntity;
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: () => context.read<HomeNotifier>().reload(),
      child: baseDataEntity.when(
        data: (snapshot) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.listData!.length + 1,
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              if (index == snapshot.listData!.length) {
                if (snapshot.isLastPage) {
                  return const SizedBox.shrink();
                } else {
                  return const ListTileShimmerComponent();
                }
              }

              final userData = snapshot.listData![index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(userData.picture),
                ),
                title: Text(userData.title),
                subtitle: Text('${userData.firstName} ${userData.lastName}'),
                onTap: () =>
                    context.read<HomeNotifier>().toProfile(userId: userData.id),
              );
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
            featureShimmerComponent: UserShimmerComponent()),
      ),
    );
  }
}
