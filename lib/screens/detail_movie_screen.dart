import 'package:flutter/material.dart';
import 'package:flutter_app/models/popular_model.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  
  PopularModel? movie;
  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context)!.settings.arguments as PopularModel;   //con esto se recupera entre pantallas el elemento que se envia
    return Scaffold(
      body: Center(child: Text(movie!.title!)),
    );
  }
}