import 'package:flutter/material.dart';
import 'package:mdb/src/bloc/base/block_provider.dart';
import 'package:mdb/src/data/model/local/genre.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen_bloc.dart';
import 'package:mdb/src/utils/pair.dart';

class FilterSheet extends StatefulWidget {

  final DiscoverScreenBloc discoverScreenBloc;

  const FilterSheet({Key key, this.discoverScreenBloc}) : super(key: key);
  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  final Set<int> _selectedGenres = Set<int>();

  DiscoverScreenBloc _discoverScreenBloc;

  @override
  Widget build(BuildContext context) {
    final _filterButton = _FilterButton(_selectedGenres);

    _discoverScreenBloc = widget.discoverScreenBloc;
    //todo rewrite this chip tile, it cause of  ui lags.
    final _filterChip = StreamBuilder(
        stream: _discoverScreenBloc.genresState,
        builder: (context, AsyncSnapshot<Pair<List<Genre>, Set<int>>> snapshot) {
          if (snapshot.hasData) {
            _selectedGenres.clear();
            _selectedGenres.addAll(snapshot.data.item2);
            print('return chipTile');
            return _ChipsTile(
              label: 'filter',
              children: snapshot.data.item1.map<Widget>((Genre genre) {
                return FilterChip(
                    key: ValueKey<String>(genre.id.toString()),
                    label: Text(genre.name),
                    selected: _selectedGenres.contains(genre.id),
                    onSelected: (bool value) {
                      setState(() {
                        if (!value) {
                          _discoverScreenBloc.selectedGenres.remove(genre.id);
                          _selectedGenres.remove(genre.id);
                          print("romoves ${_selectedGenres.toString()}");
                        } else {
                          _discoverScreenBloc.selectedGenres.add(genre.id);
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
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.only(topLeft: const Radius.circular(30), topRight: const Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
          _filterChip,
//        Container(
//          height: 300.0,
//          color: Colors.blue,
//        ),
//          _filterButton
          RaisedButton(
              child: Text('aply filter'),
              onPressed: () {
                print('apply filter: ${_selectedGenres.toString()}');
                _discoverScreenBloc.applyFilterEvent.add(_selectedGenres);
                Navigator.pop(context);
              })
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
            BlocProvider.of<DiscoverScreenBloc>(context).applyFilterEvent.add(_selectedGenres);
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
