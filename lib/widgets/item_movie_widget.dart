import 'package:flutter/material.dart';
import 'package:flutter_app/models/popular_model.dart';

class ItemMovieWidget extends StatelessWidget {
  ItemMovieWidget({super.key, required this.popularModel});

  final PopularModel popularModel;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      fit: BoxFit.cover,
      placeholder: const AssetImage('assets/loading.webp'),
      image: NetworkImage(
          'https://image.tmdb.org/t/p/w500/${popularModel.posterPath}'),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:flutter_app/models/popular_model.dart';

Widget itemMovieWidget(PopularModel movie, context){
  return GestureDetector(
    onTap: () {
      Navigator.pushNamed(context, '/detail', arguments: movie);
    },
    child: FadeInImage(
      fit: BoxFit.fill,
      fadeInDuration: const Duration(microseconds: 500),
      placeholder: const AssetImage('assets/loading.webp'),
      image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}')
    ),
  );
}*/