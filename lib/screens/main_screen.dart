import 'package:flutter/material.dart';
import 'package:flutter_base/common_styles.dart';
import 'package:flutter_base/screens/home_page.dart';
import 'package:flutter_base/screens/settings/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Screen index
  int _screenIndex = 0;
  // List screen
  final List<Widget> _screens = const [
    MyHomePage(),
    SettingScreen()
  ];
  // Icons
  final List<IconData> _icons = [
    Icons.home,
    Icons.settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNav(context),
      body: IndexedStack(
        index: _screenIndex,
        children: _screens,
      ),
    );
  }

  // Create bottom navigation bar
  Widget _buildBottomNav(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_icons.length,
              (index) => _buildItemNav(context, _icons[index], index)),
        ),
      ),
    );
  }

  // Create item bottom nav
  Widget _buildItemNav(BuildContext context, IconData icon, int index) {
    return GestureDetector(
      onTap: () => setState(() => _screenIndex = index),
      child: Icon(icon, color: _screenIndex == index ? colorByMode(context, Colors.blue, Colors.white) : Colors.grey.shade400,),
    );
  }
}
