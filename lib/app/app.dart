import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_media/app/app_navigation.dart';
import 'package:flutter_social_media/app/app_routes.dart';
import 'package:flutter_social_media/app/app_themes.dart';
import 'package:flutter_social_media/feature/home/home_notifier.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeNotifier())
      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Social Media',
            debugShowCheckedModeBanner: false,
            navigatorKey: AppNavigationKey.get(),
            onGenerateRoute: AppRoutes.onGenerate,
            onGenerateInitialRoutes: AppRoutes.initial,
            theme: AppThemes.data(),
            builder: (context, child) {
              final MediaQueryData mqd = MediaQuery.of(context);
              return MediaQuery(
                // Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(
                    textScaleFactor: mqd.textScaleFactor >= 1.15 ? 1.15 : 1.0),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
