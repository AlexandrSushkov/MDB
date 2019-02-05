import 'package:flutter/material.dart';
import 'package:mdb/mysrc/bloc/bloc.dart';
import 'package:mdb/mysrc/bloc/movie_block.dart';
import 'package:mdb/mysrc/data/model/local/movie.dart';
import 'package:mdb/mysrc/data/model/remote/discover_response.dart';
import 'package:mdb/mysrc/ui/movie_page_viver_item.dart';
import 'package:mdb/mysrc/utils/wigdet/page_transformer.dart';
import '../movie_details/movie_details.dart';

class DiscoverScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      bloc: MoviesBloc(),
      child: Scaffold(
        backgroundColor: Colors.blue,
//      body: Center(
//          child: GestureDetector(
//        child: Text('Discover Screen'),
//        onTap: () => goToDetail(context),
//      )),
      body: _MoviePageViewer(),
      ),
    );
  }

  void goToDetail(BuildContext context) {
    Route route = MaterialPageRoute(
        builder: (context) => MovieDetails(
              title: "Fight club",
              id: 550,
            ));
    Navigator.of(context).push(route);
  }

}

class _MoviePageViewer extends StatefulWidget {
  @override
  _MoviePageViewerState createState() => _MoviePageViewerState();
}

class _MoviePageViewerState extends State<_MoviePageViewer> {
  @override
  Widget build(BuildContext context) {
    final  MoviesBloc moviesBlock = BlocProvider.of<MoviesBloc>(context);
    moviesBlock.fetchDiscover();
    return StreamBuilder(
      stream: moviesBlock.discoverMovies,
      builder: (context, AsyncSnapshot<DiscoverResponse> snapshot) {
        if (snapshot.hasData) {
          return buildPageViewer(snapshot.data.movies);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildPageViewer(List<Movie> movies) {
    print('movies===> ${movies.toString()}');
    return PageTransformer(
      pageViewBuilder: (context, pageVisibilityResolver) {
        return PageView.builder(
          controller: PageController(viewportFraction: 0.85),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final item = movies[index];
            final pageVisibility = pageVisibilityResolver.resolvePageVisibility(index);
            return MoviePageViewerItem(movie: item, pageVisibility: pageVisibility);
          },
        );
      },
    );
  }
}
