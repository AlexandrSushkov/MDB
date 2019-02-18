import 'package:flutter/material.dart';
import 'package:mdb/src/ui/screen/discover/widget/filter_sheet.dart';
import 'package:mdb/src/ui/screen/discover/widget/movie_page_viewer.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body());
  }

  Widget _body() {
    return Column(
      children: <Widget>[MoviePageViewer(), _filterNavigation()],
    );
  }

  Widget _filterNavigation() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet<void>(context: context, builder: (BuildContext context) => FilterSheet());
            },
          ),
        ),
      ],
    );
  }
}
