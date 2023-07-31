import 'package:flutter/material.dart';
import 'package:flutter_social_media/feature/404/not_found_screen.dart';
import 'package:flutter_social_media/feature/favorite/favorite_screen.dart';
import 'package:flutter_social_media/feature/main/main_screen.dart';
import 'package:flutter_social_media/feature/profile/profile_screen.dart';
import 'package:flutter_social_media/feature/startup/startup_screen.dart';

class AppRoutes {
  static const String startup = "/";
  static const String home = "/home";
  static const String favorite = "/favorite";
  static const String profile = "/profile";

  static List<Route<dynamic>> initial(_) {
    return [MaterialPageRoute(builder: (_) => const StartupScreen())];
  }

  static Route<dynamic> onGenerate(RouteSettings settings) {
    switch (settings.name) {
      case startup:
        return MaterialPageRoute(builder: (_) => const StartupScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case favorite:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      case profile:
        return MaterialPageRoute(
            builder: (_) =>
                ProfileScreen(userId: settings.arguments as String));
    }

    return MaterialPageRoute(builder: (_) => const NotFoundScreen());
  }
}
