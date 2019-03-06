import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/utils/constants.dart';

class MovieDetailsScreenIos extends StatelessWidget {
  const MovieDetailsScreenIos({Key key, @required this.movie})
      : assert(movie != null),
        super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return CupertinoPageScaffold(navigationBar: CupertinoNavigationBar(middle: Text('${movie.title}'),),
        child: SafeArea(child: _body(context)));
  }

  Widget _body(BuildContext context) {
    return Stack(children: <Widget>[
      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _header(context),
          ],
        ),
      ),
//      _appBar(),
    ]);
  }

//  Widget _appBar() {
//    return Container(
//      height: 100.0,
//      child: AppBar(
//        backgroundColor: Colors.transparent,
//        elevation: 0.0,
//        brightness: Brightness.light,
//      ),
//    );
//  }

  Widget _header(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            height: 200.0,
            decoration:
            BoxDecoration(image: DecorationImage(image: NetworkImage('$imageBaseUrl$imageSizePrefixLarge${movie.backdropPath}'), fit: BoxFit.cover))),
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [CupertinoColors.activeGreen],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 120.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(
                    tag: 'poster${movie.id}',
                    child: Card(
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Container(
                          height: 200.0,
                          width: 150.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(image: NetworkImage('$imageBaseUrl$imageSizePrefixLarge${movie.posterPath}'), fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star_half),
                      Icon(Icons.star_border),
                      Icon(Icons.star_border),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(movie.title, style: Theme.of(context).textTheme.headline),
              SizedBox(
                height: 20.0,
              ),
              Text(
                movie.overview,
                style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0, color: Colors.grey[600]),
              ),
              Text(
                movie.overview,
                style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0, color: Colors.grey[600]),
              ),
              Text(
                movie.overview,
                style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0, color: Colors.grey[600]),
              ),
              Text(
                movie.overview,
                style: Theme.of(context).textTheme.body1.copyWith(fontSize: 16.0, color: Colors.grey[600]),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _poster() {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 24.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: 'poster${movie.id}',
            child: SizedBox(
              width: 120,
              height: 180,
              child: Container(
                width: 120.0,
                height: 180.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.network(
                    '$imageBaseUrl$imageSizePrefixLarge${movie.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
