import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/bloc/discover_block.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/data/model/remote/responce/genres_response.dart';
import 'package:mdb/src/ui/screen/discover/widget/movie_page_viewer.dart';
import 'package:mdb/src/utils/pair.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: discoverBloc, child: Scaffold(body: _body()));
  }

  Widget _body() {
    return Column(
      children: <Widget>[MoviePageViewer(), _filterNavigation()],
    );
  }

  Widget _filterNavigation() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
          child: IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet<void>(context: context, builder: (BuildContext context) => _Filter());
            },
          ),
        ),
      ],
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

    //todo rewrite this chip tile, it cause of  ui lags.
    final _filterChip = StreamBuilder(
        stream: BlocProvider.of<DiscoverScreenBloc>(context).genres,
        builder: (context, AsyncSnapshot<Pair<GenresResponse, Set<int>>> snapshot) {
          if (snapshot.hasData) {
            _selectedGenres.clear();
            _selectedGenres.addAll(snapshot.data.item2);
            print('return chipTile');
            return _ChipsTile(
              label: 'filter',
              children: snapshot.data.item1.genres.map<Widget>((Genre genre) {
                return FilterChip(
                    key: ValueKey<String>(genre.id.toString()),
                    label: Text(genre.name),
                    selected: _selectedGenres.contains(genre.id),
                    onSelected: (bool value) {
                      setState(() {
                        if (!value) {
                          BlocProvider.of<DiscoverScreenBloc>(context).selectedGenres.remove(genre.id);
                          _selectedGenres.remove(genre.id);
                          print("romoves ${_selectedGenres.toString()}");
                        } else {
                          BlocProvider.of<DiscoverScreenBloc>(context).selectedGenres.add(genre.id);
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
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          _filterChip,
//        Container(
//          height: 300.0,
//          color: Colors.blue,
//        ),
          _filterButton
        ]),
      ),
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
            BlocProvider.of<DiscoverScreenBloc>(context).fetchDiscoverByFilter(_selectedGenres);
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
