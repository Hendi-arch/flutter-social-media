import 'package:flutter/material.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/feature/home/home_notifier.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: baseDataEntity.when(
        data: (snapshot) {
          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.listData!.length,
            padding: const EdgeInsets.all(15),
            itemBuilder: (context, index) {
              final userData = snapshot.listData![index];
              return ListTile(
                title: Text(userData.id),
                subtitle: Text('${userData.firstName} ${userData.lastName}'),
              );
            },
          );
        },
        error: (error) => Center(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(error.stateDescription),
        )),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
