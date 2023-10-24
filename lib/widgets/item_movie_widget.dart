import 'package:flutter/material.dart';
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
}