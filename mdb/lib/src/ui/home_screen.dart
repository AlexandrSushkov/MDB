import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/movie_block.dart';
import 'package:mdb/src/data/model/local/genre.dart';
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
          return _Filter();
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

class _Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<_Filter> {
  final Set<String> _selectedGenres = Set<String>();

  @override
  Widget build(BuildContext context) {
    final _filterButton = _FilterButton();

    final _filterChip = StreamBuilder(
        stream: bloc.genres,
        builder: (context, AsyncSnapshot<GenresResponse> snapshot) {
          if (snapshot.hasData) {
            return _ChipsTile(
              label: 'filter',
              children: snapshot.data.genres.map<Widget>((Genre genre) {
                return FilterChip(
                    key: ValueKey<String>(genre.name),
                    label: Text(genre.name),
                    selected: _selectedGenres.contains(genre.name),
                    onSelected: (bool value) {
                      setState(() {
                        if (!value) {
                          _selectedGenres.remove(genre.name);
                        } else {
                          _selectedGenres.add(genre.name);
                        }
                      });
                    });
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });

    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Theme.of(context).disabledColor))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: <Widget>[_filterChip, _filterButton]),
    );
  }
}

class _FilterButton extends StatefulWidget {
  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<_FilterButton> {
  bool _isShow = true;

  @override
  Widget build(BuildContext context) {
    if (_isShow) {
      return RaisedButton(
          child: Text('aply filter'),
          onPressed: () {
            print("on ckick");
          });
    } else {
      return IgnorePointer(
          ignoring: true,
          child: new Opacity(
            opacity: 0.0,
            child: Container(),
          ));
    }
  }

  void setVisibility(bool isShow) {
    setState(() {
      this._isShow = isShow;
    });
  }
}

class _ChipsTile extends StatelessWidget {
  const _ChipsTile({
    Key key,
    this.label,
    this.children,
  }) : super(key: key);

  final String label;
  final List<Widget> children;

  // Wraps a list of chips into a ListTile for display as a section in the demo.
  @override
  Widget build(BuildContext context) {
    final List<Widget> cardChildren = <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
        alignment: Alignment.center,
        child: Text(label, textAlign: TextAlign.start),
      ),
    ];
    if (children.isNotEmpty) {
      cardChildren.add(Wrap(
          children: children.map<Widget>((Widget chip) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: chip,
        );
      }).toList()));
    } else {
      final TextStyle textStyle = Theme.of(context).textTheme.caption.copyWith(fontStyle: FontStyle.italic);
      cardChildren.add(Semantics(
        container: true,
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
          padding: const EdgeInsets.all(8.0),
          child: Text('None', style: textStyle),
        ),
      ));
    }

//    return Card(
//        semanticContainer: false,
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          children: cardChildren,
//        ));

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: cardChildren,
    );
  }
}
