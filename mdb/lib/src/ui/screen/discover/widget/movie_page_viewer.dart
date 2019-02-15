import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/movie_block.dart';
import 'package:mdb/src/data/model/remote/responce/movie_list_response.dart';
import 'package:mdb/src/ui/screen/discover/widget/movie_page_viver_item.dart';
import 'package:mdb/src/utils/wigdet/page_transformer.dart';

class MoviePageViewer extends StatefulWidget {
  @override
  _MoviePageViewerState createState() => _MoviePageViewerState();
}

class _MoviePageViewerState extends State<MoviePageViewer> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: bloc.discoverMovies,
        builder: (context, AsyncSnapshot<MovieListResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.movies.length == 0) {
              return Center(child: Text("movies not found."));
            } else {
              return PageTransformer(
                pageViewBuilder: (context, pageVisibilityResolver) {
                  return PageView.builder(
                    controller: PageController(viewportFraction: 0.85, initialPage: 0, keepPage: false),
                    itemCount: snapshot.data.movies.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data.movies[index];
                      final pageVisibility = pageVisibilityResolver.resolvePageVisibility(index);
                      return MoviePageViewerItem(movie: item, pageVisibility: pageVisibility);
                    },
                  );
                },
              );
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
