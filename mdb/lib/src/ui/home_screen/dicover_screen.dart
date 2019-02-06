import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/bloc.dart';
import 'package:mdb/src/bloc/movie_block.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/data/model/remote/discover_response.dart';
import 'package:mdb/src/data/model/remote/genres_response.dart';
import 'package:mdb/src/ui/movie_page_viver_item.dart';
import 'package:mdb/src/util/wigdet/page_transformer.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  VoidCallback _showBottomSheetCallback;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
//       disable the button
      _showBottomSheetCallback = null;
    });
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) => _Filter()).closed.whenComplete(() {
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
    return BlocProvider(
      bloc: MoviesBloc(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue,
        body: _MoviePageViewer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(24.0),
              child: FloatingActionButton(
                onPressed: _showBottomSheetCallback,
//                onPressed: (){print('on click');},
                tooltip: 'Increment',
                child: Icon(Icons.filter_list),
                elevation: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoviePageViewer extends StatefulWidget {
  @override
  _MoviePageViewerState createState() => _MoviePageViewerState();
}

class _MoviePageViewerState extends State<_MoviePageViewer> {
  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBlock = BlocProvider.of<MoviesBloc>(context);
//    moviesBlock.fetchDiscover();
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
  final Set<int> _selectedGenres = Set<int>();

  @override
  Widget build(BuildContext context) {
    final _filterButton = _FilterButton(_selectedGenres);

    final MoviesBloc moviesBlock = BlocProvider.of<MoviesBloc>(context);
//    moviesBlock.fetchGenres();
    final _filterChip = StreamBuilder(
        stream: moviesBlock.genres,
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
  _FilterButton(this._selectedGenres);

  final Set<int> _selectedGenres;

  @override
  _FilterButtonState createState() => _FilterButtonState(_selectedGenres);
}

class _FilterButtonState extends State<_FilterButton> {
  bool _isShow = true;
  Set<int> _selectedGenres;

  _FilterButtonState(this._selectedGenres);

  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBlock = BlocProvider.of<MoviesBloc>(context);

    if (_isShow) {
      return RaisedButton(
          child: Text('aply filter'),
          onPressed: () {
            print('${_selectedGenres.toString()}');
            moviesBlock.fetchDiscoverByFilter(_selectedGenres);
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
