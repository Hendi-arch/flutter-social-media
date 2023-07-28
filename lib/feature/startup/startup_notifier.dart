import 'package:flutter/foundation.dart';
import 'package:flutter_social_media/app/app_navigation.dart';
import 'package:flutter_social_media/app/app_routes.dart';

class StartupNotifier extends ChangeNotifier with AppNavigationMixin {
  Future<void> handleStartup() async {
    Future.delayed(const Duration(milliseconds: 1000), () => removeCurrentAndGoNamed(route: AppRoutes.home));
  }
}
