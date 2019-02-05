import 'package:flutter/material.dart';
import 'package:mdb/mysrc/data/model/local/genre.dart';
import 'package:mdb/mysrc/data/model/local/movie.dart';
import 'package:mdb/mysrc/data/model/remote/discover_response.dart';
import 'package:mdb/mysrc/data/model/remote/genres_response.dart';
import 'package:mdb/mysrc/data/model/remote/popular_movies_responce.dart';
import 'package:mdb/mysrc/ui/movie_page_viver_item.dart';
import 'package:mdb/mysrc/utils/constants.dart';
import 'package:mdb/mysrc/utils/wigdet/page_transformer.dart';

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
        .showBottomSheet<void>((BuildContext context) => _Filter())
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
//    bloc.fetchAllMovies();
//    bloc.fetchDiscover();
//    bloc.fetchGenres();
    return Scaffold(
      key: _scaffoldKey,
      body: _MoviePageViewer(),
      bottomNavigationBar: _BottomAppBar(_showBottomSheetCallback),
    );
  }

  Widget buildList(AsyncSnapshot<PopularMoviesResponse> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.movies.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '$imageBaseUrl$imageSizePrefixSmall${snapshot.data.movies[index].posterPath}',
            fit: BoxFit.cover,
          );
        });
  }
}

class _MoviePageViewer extends StatefulWidget {
  @override
  _MoviePageViewerState createState() => _MoviePageViewerState();
}

class _MoviePageViewerState extends State<_MoviePageViewer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
//      stream: bloc.discoverMovies,
      builder: (context, AsyncSnapshot<DiscoverResponse> snapshot) {
        if (snapshot.hasData) {
          return buildPageViewer(null);
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
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

class _BottomAppBar extends StatelessWidget {
  _BottomAppBar(this._showBottomSheetCallback);

  VoidCallback _showBottomSheetCallback;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
    );
  }
}

class _Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<_Filter> {
  final Set<int> _selectedGenres = Set<int>();

  @override
  Widget build(BuildContext context) {
    final _filterButton = _FilterButton(_selectedGenres);

    final _filterChip = StreamBuilder(
//        stream: bloc.genres,
        builder: (context, AsyncSnapshot<GenresResponse> snapshot) {
          if (snapshot.hasData) {
            return _ChipsTile(
              label: 'filter',
              children: snapshot.data.genres.map<Widget>((Genre genre) {
                return FilterChip(
                    key: ValueKey<String>(genre.name),
                    label: Text(genre.name),
                    selected: _selectedGenres.contains(genre.id),
                    onSelected: (bool value) {
                      setState(() {
                        if (!value) {
                          _selectedGenres.remove(genre.id);
                          print("romoves ${_selectedGenres.toString()}");

                        } else {
                          _selectedGenres.add(genre.id);
                          print("added ${_selectedGenres.toString()}");

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
  Set<int> _selectedGenres;

  _FilterButton(this._selectedGenres);

  @override
  _FilterButtonState createState() => _FilterButtonState(_selectedGenres);

}

class _FilterButtonState extends State<_FilterButton> {

  bool _isShow = true;
  Set<int> _selectedGenres;

  _FilterButtonState(this._selectedGenres);

  @override
  Widget build(BuildContext context) {
    if (_isShow) {
      return RaisedButton(
          child: Text('aply filter'),
          onPressed: () {
            print('${_selectedGenres.toString()}');
//            bloc.fetchDiscoverByFilter(_selectedGenres);
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
      final TextStyle textStyle = Theme
          .of(context)
          .textTheme
          .caption
          .copyWith(fontStyle: FontStyle.italic);
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
