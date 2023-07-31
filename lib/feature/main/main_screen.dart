import 'package:flutter/material.dart';
import 'package:flutter_social_media/feature/feed/feed_screen.dart';
import 'package:flutter_social_media/feature/home/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static final List<Map<String, dynamic>> _featureOptions = [
    {
      'title': 'Users',
      'feature': const HomeScreen(key: ValueKey(0)),
    },
    {
      'title': 'Posts',
      'feature': const FeedScreen(key: ValueKey(1)),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_featureOptions.elementAt(_selectedIndex)['title']),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _featureOptions.elementAt(_selectedIndex)['feature'],
          transitionBuilder: (child, animation) {
            Animation<Offset> offsetAnimation = Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(position: offsetAnimation, child: child);
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Posts',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
