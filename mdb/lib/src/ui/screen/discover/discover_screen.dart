import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen_bloc.dart';
import 'package:mdb/src/ui/screen/discover/widget/filter_sheet.dart';
import 'package:mdb/src/ui/screen/discover/widget/movie_page_viewer.dart';
import 'package:rxdart/rxdart.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  DiscoverScreenBloc _discoverScreenBloc;
  GlobalKey<ScaffoldState> _key;

  @override
  void initState() {
    _key = GlobalKey<ScaffoldState>();
    _discoverScreenBloc = BlocProvider.of<DiscoverScreenBloc>(context);
    _discoverScreenBloc.onFilterClickState.listen((_) {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) => FilterSheet(
                discoverScreenBloc: _discoverScreenBloc,
              ));
    });
    _discoverScreenBloc.errorHandlerState.listen((errorMessage) {
      _key.currentState.showSnackBar(SnackBar(
        content: new Text(errorMessage),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _key, body: _buildBody());
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[_buildMoviePageViewer(), _buildFilterNavigation()],
    );
  }

  Widget _buildMoviePageViewer() => MoviePageViewer();

  Widget _buildFilterNavigation() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _discoverScreenBloc.onFilterClickEvent.add(VoidFunc);
            },
          ),
        ),
      ],
    );
  }
}
