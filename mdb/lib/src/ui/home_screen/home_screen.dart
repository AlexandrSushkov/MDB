import 'package:flutter/material.dart';
import 'package:mdb/src/resource/resource.dart';
import 'package:mdb/src/ui/home_screen/dicover_screen.dart';
import 'package:mdb/src/ui/search_screen.dart';
import 'package:mdb/src/ui/home_screen/watch_list_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final List<Widget> _navigationItemList = [
    DiscoverScreenNavigator(),
    SearchScreen(),
    WatchListScreen()
  ];

  var pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationItemList[pageIndex],
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
    return BottomNavigationBar(
        currentIndex: startIndex,
        onTap: navigate,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation),
              title: Text(DISCOVER_PAGE_NAME)
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text(SEARCH_PAGE_NAME)
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.star_border),
              title: Text(WATCH_LIST_PAGE_NAME)
          ),
        ]);
  }

}
