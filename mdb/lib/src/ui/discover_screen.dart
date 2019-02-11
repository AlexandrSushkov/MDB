import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/movie_block.dart';
import 'package:mdb/src/data/model/local/genre_jo.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/data/model/remote/responce/discover_response.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/data/model/remote/responce/popular_movies_responce.dart';
import 'package:mdb/src/ui/movie_page_viver_item.dart';
import 'package:mdb/src/utils/constants.dart';
import 'package:mdb/src/utils/wigdet/page_transformer.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: bloc.discoverMovies,
        builder: (context, AsyncSnapshot<DiscoverResponse> snapshot) {
          if (snapshot.data.movies.length == 0) {
            return Center(child: Text("movies not found."));
          }
          if (snapshot.hasData) {
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
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(context: context, builder: (BuildContext context) => _Filter());

        },
        child: Icon(Icons.filter_list),
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
    return StreamBuilder(
      stream: bloc.discoverMovies,
      builder: (context, AsyncSnapshot<DiscoverResponse> snapshot) {
        if (snapshot.data.movies.length == 0) {
          return Center(child: Text("movies not found."));
        }
        if (snapshot.hasData) {
          return PageTransformer(
            pageViewBuilder: (context, pageVisibilityResolver) {
              return PageView.builder(
                controller: PageController(viewportFraction: 0.85, initialPage: 0),
                itemCount: snapshot.data.movies.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data.movies[index];
                  final pageVisibility = pageVisibilityResolver.resolvePageVisibility(index);
                  return MoviePageViewerItem(movie: item, pageVisibility: pageVisibility);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

//  Widget buildPageViewer(List<Movie> movies) {
//    return PageTransformer(
//      pageViewBuilder: (context, pageVisibilityResolver) {
//        return PageView.builder(
//          controller: PageController(viewportFraction: 0.85),
//          itemCount: movies.length,
//          itemBuilder: (context, index) {
//            final item = movies[index];
//            final pageVisibility = pageVisibilityResolver.resolvePageVisibility(index);
//            return MoviePageViewerItem(movie: item, pageVisibility: pageVisibility);
//          },
//        );
//      },
//    );
//  }
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
        stream: bloc.genres,
        builder: (context, AsyncSnapshot<Pair<GenresResponse, Set<int>>> snapshot) {
          if (snapshot.hasData) {
            _selectedGenres.clear();
            _selectedGenres.addAll(snapshot.data.second);
            return _ChipsTile(
              label: 'filter',
              children: snapshot.data.first.genres.map<Widget>((GenreJo genre) {
                return FilterChip(
                    key: ValueKey<String>(genre.id.toString()),
                    label: Text(genre.name),
                    selected: _selectedGenres.contains(genre.id),
                    onSelected: (bool value) {
                      setState(() {
                        if (!value) {
                          bloc.selectedGenres.remove(genre.id);
                          _selectedGenres.remove(genre.id);
                          print("romoves ${_selectedGenres.toString()}");
                        } else {
                          bloc.selectedGenres.add(genre.id);
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
            print('apply filter: ${_selectedGenres.toString()}');
            bloc.fetchDiscoverByFilter(_selectedGenres);
            Navigator.pop(context);
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
