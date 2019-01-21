import 'package:flutter/material.dart';
import 'package:mdb/src/resource/resource.dart';
import 'package:mdb/src/ui/home_screen/dicover_screen.dart';
import 'package:mdb/src/ui/home_screen/search_screen.dart';
import 'package:mdb/src/ui/home_screen/watch_list_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final List<Widget> _navigationItemList = [
    DiscoverScreen(),
    SearchScreen(),
    WatchListScreen()
  ];

  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewPagerHomeScreen(pageIndex, _navigationItemList, onPgeChanged),
      bottomNavigationBar: BottomNav(pageIndex, onPgeChanged),
    );
  }

  void onPgeChanged(int index) {
    setState(() {
      this.pageIndex = index;
    });
  }

}

class BottomNav extends StatelessWidget {
  final startIndex;
  final navigate;

  BottomNav(this.startIndex, this.navigate);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(currentIndex: startIndex,
        onTap: navigate,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation),
              title: Text(DISCOVER_PAGE_NAME)
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(DISCOVER_PAGE_NAME)
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              title: Text(DISCOVER_PAGE_NAME)
          ),
        ]);
  }

}

class ViewPagerHomeScreen extends StatelessWidget {
  final int index;
  final onPageChanged;
  final List<Widget> navigationItems;

  PageController _pageController;

  ViewPagerHomeScreen(this.index, this.navigationItems, this.onPageChanged);

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: index);

    return PageView(
      children: navigationItems,
      onPageChanged: onPageChanged,
      controller: _pageController,
    );
  }

}
