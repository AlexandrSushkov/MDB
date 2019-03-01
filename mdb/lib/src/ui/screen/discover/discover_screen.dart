import 'package:flutter/material.dart';
import 'package:mdb/src/redux/containers/app_loading.dart';
import 'package:mdb/src/redux/presentation/loading_indicator.dart';
import 'package:mdb/src/ui/screen/discover/widget/movie_page_viewer.dart';

class DiscoverScreen extends StatefulWidget {
  final void Function() onInit;

  const DiscoverScreen({Key key, this.onInit}) : super(key: key);

  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  GlobalKey<ScaffoldState> _key;

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        body: AppLoading(
          builder: (context, loading) {
            return loading ? LoadingIndicator() : _buildBody();
          },
        ));
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
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
