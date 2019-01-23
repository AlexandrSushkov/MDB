import 'package:flutter/material.dart';

class MovieDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Movie detail'),
      ),
    );
  }
}

// class MovieDetailPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // Navigator in our app.
//    return Navigator(
//      initialRoute: '/movie_details',
//      onGenerateRoute: (RouteSettings settings) {
//        WidgetBuilder builder = (BuildContext _) => MovieDetailScreen();
////        switch (settings.name) {
////          case 'signup/personal_info':
////            // Assume CollectPersonalInfoPage collects personal info and then
////            // navigates to 'signup/choose_credentials'.
////            builder = (BuildContext _) => CollectPersonalInfoPage();
////            break;
////          case 'signup/choose_credentials':
////            // Assume ChooseCredentialsPage collects new credentials and then
////            // invokes 'onSignupComplete()'.
////            builder = (BuildContext _) => ChooseCredentialsPage(
////              onSignupComplete: () {
////                // Referencing Navigator.of(context) from here refers to the
////                // top level Navigator because SignUpPage is above the
////                // nested Navigator that it created. Therefore, this pop()
////                // will pop the entire "sign up" journey and return to the
////                // "/" route, AKA HomePage.
////                Navigator.of(context).pop();
////              },
////            );
////            break;
////          default:
////            throw Exception('Invalid route: ${settings.name}');
////        }
//        return MaterialPageRoute(builder: builder, settings: settings);
//      },
//    );
//  }
// }
