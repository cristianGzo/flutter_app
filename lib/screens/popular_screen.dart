import 'package:flutter/material.dart';
import 'package:flutter_app/models/popular_model.dart';
import 'package:flutter_app/network/api_popular.dart';
import 'package:flutter_app/widgets/item_movie_widget.dart';

//rutas nombradas
class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  ApiPopular? apiPopular;
  
  @override
  void initState(){
    super.initState();
    apiPopular=ApiPopular();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies'),),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
        builder: (context, AsyncSnapshot<List<PopularModel>?>snapshot) {
          if(snapshot.hasData){
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .9,
              ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index){
              return itemMovieWidget(snapshot.data![index], context);
            },
          );
          }else{
            if(snapshot.hasError){
              return Center(child: Text('Algo salió mal :()'));
            }else{
              return CircularProgressIndicator();
            }
          }
          
        },
      ),
    );
  }
}