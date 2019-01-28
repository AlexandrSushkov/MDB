import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/movie_block.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/src/ui/movie_page_viver_item.dart';
import 'package:mdb/src/utils/constants.dart';
import 'package:mdb/src/utils/wigdet/page_transformer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      // disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState
        .showBottomSheet<void>((BuildContext context) {
          final ThemeData themeData = Theme.of(context);
          return Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: themeData.disabledColor))),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: <Widget>[
                  StreamBuilder(
                    stream: bloc.genres,
                    builder: (context, AsyncSnapshot<GenresResponse> snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.genres.toString());
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  )
                ]),
              ));
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              // re-enable the button
              _showBottomSheetCallback = _showBottomSheet;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    bloc.fetchGenres();
    return Scaffold(
      key: _scaffoldKey,
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
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: _showBottomSheetCallback,
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList(AsyncSnapshot<PopularMoviesResponse> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.movies.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '$imagePrefixSmall${snapshot.data.movies[index].poster_path}',
            fit: BoxFit.cover,
          );
        });
  }

  Widget buildPageViewer(List<Movie> movies) {
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
