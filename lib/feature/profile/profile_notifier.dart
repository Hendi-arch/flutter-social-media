import 'package:flutter/material.dart';
import 'package:flutter_social_media/app/app_navigation.dart';
import 'package:flutter_social_media/app/app_state.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/entity/pagination_entity.dart';
import 'package:flutter_social_media/entity/post/post_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:flutter_social_media/repository/profile/profile_repository.dart';

class ProfileNotifier with ChangeNotifier, AppNavigationMixin {
  // Class Repositories
  final ProfileRepository _feedRepository = ProfileRepository();

  // Class Attributes
  BaseEntity<PaginationEntity<PostEntity>> _listFeedBaseDataEntity =
      BaseEntity<PaginationEntity<PostEntity>>.loading();

  BaseEntity<UserEntity> _profileBaseDataEntity =
      BaseEntity<UserEntity>.loading();

  int _page = 0;
  final int _limit = 20;

  // Class getter attributes
  BaseEntity<PaginationEntity<PostEntity>> get listFeedBaseDataEntity =>
      _listFeedBaseDataEntity;

  BaseEntity<UserEntity> get profileBaseDataEntity => _profileBaseDataEntity;

  bool get isListFeedRequestBusy =>
      _listFeedBaseDataEntity.state == AppState.loading;

  Future<void> loadProfile({required String userId}) async {
    _setStateProfile();
    final profileData = await _feedRepository.getProfile(userId: userId);
    _profileBaseDataEntity = profileData;
    notifyListeners();
  }

  Future<void> loadListFeed({required String userId}) async {
    _setStateListFeed();
    final feedData = await _feedRepository.getProfileListFeed(
        page: _page, limit: _limit, userId: userId);
    feedData.when(
      data: (res) {
        if (res.listData!.isNotEmpty) _page++;
        if (_listFeedBaseDataEntity.data == null) {
          _listFeedBaseDataEntity = feedData;
          _listFeedBaseDataEntity.data!.isLastPage = res.isLastPage;
        } else {
          _listFeedBaseDataEntity.data!.isLastPage = res.isLastPage;
          _listFeedBaseDataEntity.state = feedData.state;
          _listFeedBaseDataEntity.data!.listData = [
                ..._listFeedBaseDataEntity.data?.listData ??
                    [] as List<PostEntity>
              ] +
              res.listData!;
        }
        notifyListeners();
      },
      error: (error) {
        _listFeedBaseDataEntity.state = error.state;
        _listFeedBaseDataEntity.stateDescription = error.stateDescription;
        notifyListeners();
      },
    );
  }

  Future<void> reload({required String userId}) async {
    loadProfile(userId: userId);
    _reloadListFeed(userId: userId);
  }

  Future<void> _reloadListFeed({required String userId}) async {
    _resetPaginationAttributes();
    _setStateListFeed();
    final feedData = await _feedRepository.getProfileListFeed(userId: userId);
    _listFeedBaseDataEntity = feedData;
    feedData.when(
      data: (res) {
        if (res.listData!.isNotEmpty) _page++;
        _listFeedBaseDataEntity.data!.isLastPage = res.isLastPage;
      },
      error: (error) {},
    );
    notifyListeners();
  }

  void scrollListener(
      {required ScrollController scrollController, required String userId}) {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        !isListFeedRequestBusy) {
      loadListFeed(userId: userId);
    }
  }

  void onPop() {
    _listFeedBaseDataEntity =
        BaseEntity<PaginationEntity<PostEntity>>.loading();
    _profileBaseDataEntity = BaseEntity<UserEntity>.loading();
    _resetPaginationAttributes();
    back();
  }

  void _setStateProfile() {
    _profileBaseDataEntity.setStateLoading();
    notifyListeners();
  }

  void _setStateListFeed() {
    _listFeedBaseDataEntity.setStateLoading();
    notifyListeners();
  }

  void _resetPaginationAttributes() {
    _page = 0;
  }
}
