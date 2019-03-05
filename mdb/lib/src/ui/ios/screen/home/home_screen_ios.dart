import 'package:flutter/cupertino.dart';
import 'package:mdb/src/redux/containers/app_loading.dart';
import 'package:mdb/src/redux/presentation/loading_indicator.dart';
import 'package:mdb/src/ui/ios/screen/home/widget/movie_page_viewer_ios.dart';

class HomeScreenIos extends StatefulWidget {
  final void Function() onInit;

  const HomeScreenIos({Key key, this.onInit}) : super(key: key);

  @override
  _HomeScreenIosState createState() => _HomeScreenIosState();
}

class _HomeScreenIosState extends State<HomeScreenIos> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(child: AppLoading(
      builder: (context, loading) {
        return loading ? LoadingIndicator() : MoviePageViewerIos();
      },
    ));
  }
}
