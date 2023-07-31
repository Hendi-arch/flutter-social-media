import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/feature/profile/profile_notifier.dart';
import 'package:flutter_social_media/feature/profile/widgets/profile_bio_widget.dart';
import 'package:flutter_social_media/shared/components/feed_component.dart';
import 'package:flutter_social_media/shared/components/feed_shimmer_component.dart';
import 'package:flutter_social_media/shared/components/list_screen_shimmer_loading.dart';
import 'package:flutter_social_media/shared/components/profile_shimmer_component.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ProfileNotifier>().reload(userId: widget.userId);
      _scrollController.addListener(() => context
          .read<ProfileNotifier>()
          .scrollListener(
              scrollController: _scrollController, userId: widget.userId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileBaseEntity =
        context.watch<ProfileNotifier>().profileBaseDataEntity;
    final listFeedBaseEntity =
        context.watch<ProfileNotifier>().listFeedBaseDataEntity;
    return WillPopScope(
      onWillPop: () {
        context.read<ProfileNotifier>().onPop();
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: () =>
              context.read<ProfileNotifier>().reload(userId: widget.userId),
          child: CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    height: MediaQuery.sizeOf(context).height * 0.36,
                    child: profileBaseEntity.when(
                      data: (data) {
                        return Column(
                          children: [
                            Container(
                              height: 100.r,
                              width: 100.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(data.picture),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(),
                              ),
                            ),
                            SizedBox(height: 5.w),
                            Text('${data.firstName} ${data.lastName}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.bold)),
                            SizedBox(height: 5.w),
                            ProfileBioWidget(
                              title: 'Gender',
                              value: data.gender,
                            ),
                            SizedBox(height: 5.w),
                            ProfileBioWidget(
                              title: 'Date of Birth',
                              value: data.dateOfBirth == null
                                  ? ''
                                  : DateFormat('dd MMMM yyyy')
                                      .format(data.dateOfBirth!),
                            ),
                            SizedBox(height: 5.w),
                            ProfileBioWidget(
                              title: 'Join From',
                              value: data.registerDate == null
                                  ? ''
                                  : DateFormat('dd MMMM yyyy')
                                      .format(data.registerDate!),
                            ),
                            SizedBox(height: 5.w),
                            ProfileBioWidget(
                              title: 'Email',
                              value: data.email,
                            ),
                            SizedBox(height: 5.w),
                            ProfileBioWidget(
                              title: 'Address',
                              value: data.userLocation == null
                                  ? ''
                                  : '${data.userLocation!.country}, ${data.userLocation!.state}, ${data.userLocation!.city}, ${data.userLocation!.street}',
                            ),
                          ],
                        );
                      },
                      error: (error) {
                        return Center(child: Text(error.stateDescription));
                      },
                      loading: () => const ProfileShimmerComponent(),
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 10)),
              SliverToBoxAdapter(
                child: Container(
                  height: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  color: Colors.grey,
                ),
              ),
              listFeedBaseEntity.when(
                data: (snapshot) {
                  return SliverPadding(
                    padding: const EdgeInsets.all(5),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
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
                        childCount: snapshot.listData!.length + 1,
                      ),
                    ),
                  );
                },
                error: (error) => SliverPadding(
                  padding: const EdgeInsets.all(15.0),
                  sliver: SliverToBoxAdapter(
                    child: Text(error.stateDescription),
                  ),
                ),
                loading: () => const ListScreenShimmerComponent.sliver(
                    featureShimmerComponent: FeedShimmerComponent()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
