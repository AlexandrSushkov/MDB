import 'package:flutter/cupertino.dart';
import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/ui/ios/movie_view_pager_ios.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen_bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenIos extends StatefulWidget {
  @override
  _HomeScreenIosState createState() => _HomeScreenIosState();
}

class _HomeScreenIosState extends State<HomeScreenIos> {
  DiscoverScreenBloc _discoverScreenBloc;

  @override
  void initState() {
    _discoverScreenBloc = BlocProvider.of<DiscoverScreenBloc>(context);
    _discoverScreenBloc.onFilterClickState.listen((_) {
      print('onClic filter');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[_buildMoviePageViewer(), _buildFilterNavigation()],
    );
  }

  Widget _buildMoviePageViewer() => MoviePageViewerIos();

  Widget _buildFilterNavigation() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
          child: CupertinoButton(
            child: Text('filter'),
            onPressed: () {
              _discoverScreenBloc.onFilterClickEvent.add(VoidFunc);
            },
          ),
        ),
      ],
    );
  }
}
