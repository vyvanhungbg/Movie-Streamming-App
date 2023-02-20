import 'package:cinema/main.dart';
import 'package:cinema/src/persentation/favorite/view/favorite_screen.dart';
import 'package:cinema/src/persentation/home/view/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late List<Widget> mainViews = [
    const HomePageScreen(),
    const FavoriteScreen(),
    const BlockScreen(),
    const BlockScreen(),
  ];

  void indexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget tabItem({required String label, required Icon icon}) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          icon,
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.movie),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [
          Icons.home,
          Icons.favorite,
          Icons.menu_book,
          Icons.settings,
        ],
        shadow: const BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 12,
          spreadRadius: 0.5,
          color: Colors.grey,
        ),
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        elevation: 10,
        activeColor: Colors.redAccent,
        borderWidth: 2,
        blurEffect: true,
        iconSize: 30,
        splashSpeedInMilliseconds: 200,
        leftCornerRadius: 8,
        inactiveColor: Colors.black87,
        rightCornerRadius: 8,
        onTap: (index) => setState(() => _selectedIndex = index),
        //other params
      ),
      body: SizedBox(
        width: double.infinity,
        child: IndexedStack(
          index: _selectedIndex,
          children: mainViews,
        ),
      ),
    );
  }
}
