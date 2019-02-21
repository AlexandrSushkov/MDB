import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen_bloc.dart';
import 'package:mdb/src/ui/screen/discover/widget/filter_sheet.dart';
import 'package:mdb/src/ui/screen/discover/widget/movie_page_viewer.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  DiscoverScreenBloc _discoverScreenBloc;

  @override
  Widget build(BuildContext context) {
    _discoverScreenBloc = BlocProvider.of<DiscoverScreenBloc>(context);
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
              _onFilterButtonClick();
            },
          ),
        ),
      ],
    );
  }

  void _onFilterButtonClick() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => FilterSheet(
              discoverScreenBloc: _discoverScreenBloc,
            ));
  }

//  FilterSheet _buildFilterSheet() => BlocProvider(child: FilterSheet(), bloc: BlocProvider.of<DiscoverScreenBloc>(context));
}
