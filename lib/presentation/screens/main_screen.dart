import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:la27mobile/presentation/widgets/shared/bottom_nav_bar.dart';
import 'package:la27mobile/presentation/widgets/shared/post_tuip_page.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isVisible = true;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onScroll(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse) {
        if (_isVisible) setState(() => _isVisible = false);
      } else if (notification.direction == ScrollDirection.forward) {
        if (!_isVisible) setState(() => _isVisible = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          _onScroll(notification);
          return true;
        },
        child: _screens[_selectedIndex],
      ),
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: _isVisible ? kBottomNavigationBarHeight : 0,
        width: _isVisible ? kBottomNavigationBarHeight : 0,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => PostTuipPage()));
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        isVisible: _isVisible,
      ),
    );
  }
}
