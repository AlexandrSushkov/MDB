import 'package:flutter/material.dart';
import 'package:mdb/src/data/model/local/movie.dart';
import 'package:mdb/src/ui/movie_details_screen.dart';
import 'package:mdb/src/utils/constants.dart';
import 'package:mdb/src/utils/wigdet/page_transformer.dart';

class MoviePageViewerItem extends StatelessWidget {
  MoviePageViewerItem({
    @required this.movie,
    @required this.pageVisibility,
  });

  final Movie movie;
  final PageVisibility pageVisibility;
  final double _cornerRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    var image = Image.network(
      '$imageBaseUrl$imageSizePrefixLarge${movie.poster_path}',
      fit: BoxFit.cover,
      alignment: FractionalOffset(
        0.5 + (pageVisibility.pagePosition / 3),
        0.5,
      ),
    );

    var imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_cornerRadius),
        gradient: LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [
            const Color(0xFF000000),
            const Color(0x00000000),
          ],
        ),
      ),
    );

//    return Padding(padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
//      child: PhotoPosterHero(photo: '$imagePrefixLarge${movie.poster_path}', onTap: _onPosterClick(context, movie),),
//    );

    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 48.0,
          horizontal: 8.0,
        ),
        child: Hero(
          tag: 'poster${movie.id}',
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_cornerRadius),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(_cornerRadius),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _onPosterClick(context, movie),
                      child: Image.network('$imageBaseUrl$imageSizePrefixLarge${movie.poster_path}',
                          fit: BoxFit.cover,
                          alignment: FractionalOffset(
                            0.5 + (pageVisibility.pagePosition / 3),
                            0.5,
                          )),
                    ),
                  ),
                ),
                _buildTextContainer(context),
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(onTap: () {
                    _showProductDetailsPage(context);
                  }),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _showProductDetailsPage(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)));
  }

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return Opacity(
      opacity: pageVisibility.visibleFraction,
      child: Transform(
        alignment: FractionalOffset.topLeft,
        transform: Matrix4.translationValues(
          xTranslation,
          0.0,
          0.0,
        ),
        child: child,
      ),
    );
  }

  _buildTextContainer(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: Text(
        movie.release_date,
        style: textTheme.caption.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    var titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
//        child: Text(
//          movie.title,
//          style: textTheme.title.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//          textAlign: TextAlign.center,
//        ),
        child: Hero(
          tag: movie.title,
          child: Text(
            movie.title,
            style: textTheme.title.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }
}

class PhotoPosterHero extends StatelessWidget {
  const PhotoPosterHero({Key key, this.photo, this.onTap}) : super(key: key);

  final String photo;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return Hero(
      tag: photo,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Image.network(photo, fit: BoxFit.fitHeight),
        ),
      ),
    );
  }
}

class TitleHero extends StatelessWidget {
  const TitleHero({Key key, this.title}) : super(key: key);

  final String title;

  Widget build(BuildContext context) {
    return Hero(tag: title, child: Text(title));
  }
}

VoidCallback _onPosterClick(BuildContext context, Movie movie) {
  return () {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movie: movie)));
  };
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onTap, this.width}) : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return Hero(
      tag: photo,
      child: Material(
        color: Colors.transparent,
        child: InkWell(onTap: onTap, child: Image.network(photo, fit: BoxFit.fitHeight)),
      ),
    );
  }
}
