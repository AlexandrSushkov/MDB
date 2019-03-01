import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mdb/src/redux/mdb_state.dart';
import 'package:mdb/src/redux/presentation/selector.dart';
import 'package:redux/redux.dart';

class AppLoading extends StatelessWidget {
  final Function(BuildContext context, bool isLoading) builder;

  AppLoading({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<MdbState, bool>(
      distinct: true,
      converter: (Store<MdbState> store) => isLoadingSelector(store.state),
      builder: builder,
    );
  }
}