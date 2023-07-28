import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_social_media/feature/startup/startup_notifier.dart';
import 'package:provider/provider.dart';

class StartupScreen extends StatefulWidget {
  const StartupScreen({super.key});

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  void _handleStartup() {
    context.read<StartupNotifier>().handleStartup();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _handleStartup());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Redirecting, please wait..."),
            SizedBox(height: 15.h),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
