import 'package:flutter/material.dart';
import 'package:flutter_social_media/app/app_state.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/entity/pagination_entity.dart';
import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:flutter_social_media/repository/feed/feed_repository.dart';

class FeedNotifier with ChangeNotifier {
  // Class Repositories
  final FeedRepository _feedRepository = FeedRepository();

  // Class Attributes
  BaseEntity<PaginationEntity<PostEntity>> _baseDataEntity =
      BaseEntity<PaginationEntity<PostEntity>>.loading();

  int _page = 0;
  final int _limit = 20;

  // Class getter attributes
  BaseEntity<PaginationEntity<PostEntity>> get baseDataEntity =>
      _baseDataEntity;

  bool get isBusy => _baseDataEntity.state == AppState.loading;

  Future<void> load() async {
    _setState();
    final feedData =
        await _feedRepository.getListFeed(page: _page, limit: _limit);
    feedData.when(
      data: (res) {
        if (res.listData!.isNotEmpty) _page++;
        if (_baseDataEntity.data == null) {
          _baseDataEntity = feedData;
          _baseDataEntity.data!.isLastPage = res.isLastPage;
        } else {
          _baseDataEntity.data!.isLastPage = res.isLastPage;
          _baseDataEntity.state = feedData.state;
          _baseDataEntity.data!.listData = [
                ..._baseDataEntity.data?.listData ?? [] as List<PostEntity>
              ] +
              res.listData!;
        }
        notifyListeners();
      },
      error: (error) {
        _baseDataEntity.state = error.state;
        _baseDataEntity.stateDescription = error.stateDescription;
        notifyListeners();
      },
    );
  }

  Future<void> reload() async {
    _resetPaginationAttributes();
    _setState();
    final feedData = await _feedRepository.getListFeed();
    _baseDataEntity = feedData;
    feedData.when(
      data: (res) {
        if (res.listData!.isNotEmpty) _page++;
        _baseDataEntity.data!.isLastPage = res.isLastPage;
      },
      error: (error) {},
    );
    notifyListeners();
  }

  void scrollListener(ScrollController scrollController) {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        !isBusy) {
      load();
    }
  }

  void _setState() {
    _baseDataEntity.setStateLoading();
    notifyListeners();
  }

  void _resetPaginationAttributes() {
    _page = 0;
  }
}
