import 'package:flutter/material.dart';
import 'package:flutter_social_media/app/app_navigation.dart';
import 'package:flutter_social_media/app/app_routes.dart';
import 'package:flutter_social_media/app/app_state.dart';
import 'package:flutter_social_media/entity/base_entity.dart';
import 'package:flutter_social_media/entity/pagination_entity.dart';
import 'package:flutter_social_media/entity/user/user_entity.dart';
import 'package:flutter_social_media/repository/home/home_repository.dart';

class HomeNotifier with ChangeNotifier, AppNavigationMixin {
  // Class Repositories
  final HomeRepository _homeRepository = HomeRepository();

  // Class Attributes
  BaseEntity<PaginationEntity<UserEntity>> _baseDataEntity =
      BaseEntity<PaginationEntity<UserEntity>>.loading();

  int _page = 0;
  final int _limit = 20;

  // Class getter attributes
  BaseEntity<PaginationEntity<UserEntity>> get baseDataEntity =>
      _baseDataEntity;

  bool get isBusy => _baseDataEntity.state == AppState.loading;

  Future<void> load() async {
    _setState();
    final userData =
        await _homeRepository.getListUser(page: _page, limit: _limit);
    userData.when(
      data: (res) {
        if (res.listData!.isNotEmpty) _page++;
        if (_baseDataEntity.data == null) {
          _baseDataEntity = userData;
          _baseDataEntity.data!.isLastPage = res.isLastPage;
        } else {
          _baseDataEntity.data!.isLastPage = res.isLastPage;
          _baseDataEntity.state = userData.state;
          _baseDataEntity.data!.listData = [
                ..._baseDataEntity.data?.listData ?? [] as List<UserEntity>
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
    final userData = await _homeRepository.getListUser();
    _baseDataEntity = userData;
    userData.when(
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

  void toProfile({required String userId}) {
    goNamed(route: AppRoutes.profile, arguments: userId);
  }

  void _setState() {
    _baseDataEntity.setStateLoading();
    notifyListeners();
  }

  void _resetPaginationAttributes() {
    _page = 0;
  }
}
