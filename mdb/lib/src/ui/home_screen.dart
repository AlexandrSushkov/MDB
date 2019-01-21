import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/movie_block.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/src/ui/movie_page_viver_item.dart';
import 'package:mdb/src/utils/constants.dart';
import 'package:mdb/src/utils/wigdet/page_transformer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: bloc.popularMovies,
        builder: (context, AsyncSnapshot<PopularMoviesResponse> snapshot) {
          if (snapshot.hasData) {
            return buildPageViewer(snapshot.data.movies);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<PopularMoviesResponse> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.movies.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '$posterImagePrefix${snapshot.data.movies[index].poster_path}',
            fit: BoxFit.cover,
          );
        });
  }

  Widget buildPageViewer(List<Movie> movies){
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
