import 'dart:convert';

import 'package:flutter_app/models/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiPopular{
  Uri link =  Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=5019e68de7bc112f4e4337a500b96c56&language=es-MX&page=1');


  Future<List<PopularModel>?>getAllPopular() async{
    var response = await http.get(link);  //url subconjunto de las uris
    if(response.statusCode==200){
      var jsonResult= jsonDecode(response.body)['results'] as List;
      return jsonResult.map((popular)=> PopularModel.fromMap(popular)).toList();
    }
    return null;
  }
}