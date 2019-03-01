import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/redux/mdb_state.dart';
import 'package:mdb/src/ui/screen/discover/widget/movie_page_viver_item.dart';
import 'package:mdb/src/utils/wigdet/page_transformer.dart';
import 'package:redux/redux.dart';

class MoviePageViewer extends StatefulWidget {
  @override
  _MoviePageViewerState createState() => _MoviePageViewerState();
}

class _MoviePageViewerState extends State<MoviePageViewer> {
  @override
  Widget build(BuildContext context) {
//    return Center(child: Text('viewpager'));
    return Expanded(
      child: StoreConnector<MdbState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (context, vm) {
          if (vm.movies.length == 0) {
            return Center(child: Text("movies not found."));
          } else {
            return PageTransformer(
              pageViewBuilder: (context, pageVisibilityResolver) {
                return PageView.builder(
                  controller: PageController(viewportFraction: 0.85, initialPage: 0, keepPage: false),
                  itemCount: vm.movies.length,
                  itemBuilder: (context, index) {
                    final item = vm.movies[index];
                    final pageVisibility = pageVisibilityResolver.resolvePageVisibility(index);
                    return MoviePageViewerItem(movie: item, pageVisibility: pageVisibility);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class _ViewModel {
  final List<Movie> movies;

  _ViewModel({
    @required this.movies,
  });

  static _ViewModel fromStore(Store<MdbState> store) {
    return _ViewModel(
      movies: store.state.movieListResponse.movies,
    );
  }
}
