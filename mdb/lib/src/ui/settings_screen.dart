import 'package:flutter/material.dart';
import 'package:mdb/mysrc/bloc/bloc.dart';
import 'package:mdb/mysrc/bloc/settings_bloc.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[

          ],
        ),
      ),
    );
  }

  Widget buildThemeSwitcher(BuildContext context) {
    final  SettingBloc settings = BlocProvider.of<SettingBloc>(context);
    return StreamBuilder<bool> (
      stream: settings.outController,
      initialData: true,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
//          return Switch(snapshot.data, value: snapshot.data,);
        }
      },
    );

  }


}

