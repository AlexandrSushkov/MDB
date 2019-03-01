import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mdb/src/redux/actions/actions.dart';
import 'package:mdb/src/redux/mdb_state.dart';
import 'package:mdb/src/redux/middleware/movies_middleware.dart';
import 'package:mdb/src/redux/reducers/mdb_reducer.dart';
import 'package:mdb/src/redux/routes/MdbRoutes.dart';
import 'package:mdb/src/ui/screen/discover/discover_screen.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  final store = Store<MdbState>(mdbReducer, initialState: MdbState.loading(), middleware: moviesMiddleware());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<MdbState>(
      store: store,
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.white),
        routes: {
          MdbRoutes.home: (context) {
            return DiscoverScreen(onInit: () {
              StoreProvider.of<MdbState>(context).dispatch(LoadMoviesAction());
            });
          }
        },
      ),
    );
  }
}
