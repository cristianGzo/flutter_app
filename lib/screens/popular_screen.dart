import 'package:flutter/material.dart';
import 'package:flutter_app/models/popular_model.dart';
import 'package:flutter_app/network/api_popular.dart';
import 'package:flutter_app/provider/test_provider.dart';
import 'package:flutter_app/screens/detail_movie_screen.dart';
import 'package:flutter_app/widgets/item_movie_widget.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:provider/provider.dart';


//rutas nombradas
class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {

  AgendaDB? agendaDB;
  ApiPopular? apiPopular;
  int favoriteCount = 0;
  
  @override
  void initState(){
    super.initState();
    apiPopular=ApiPopular();
    agendaDB = AgendaDB();
  }
  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies'),),
      
      body:  FutureBuilder(
        future: flag.getupdatePosts() == true
            ? favoriteCount == 0
                ? agendaDB!.GETALLPOPULAR()
                : apiPopular!.getAllPopular()
            : favoriteCount == 1
                ? agendaDB!.GETALLPOPULAR()
                : apiPopular!.getAllPopular(),
                builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.isNotEmpty) {
              return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: .8,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  PopularModel model = snapshot.data![index];
                  if (snapshot.hasData) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    DetailMovieScreen.model(model: model)));
                      },
                      child:
                          ItemMovieWidget(popularModel: snapshot.data![index]),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Algo salio mal :()'),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
                itemCount: snapshot.data != null
                    ? snapshot.data!.length
                    : 0, //snapshot.data!.length,
              );
            } else {
              return const Center(
                child: Text(
                  'Esta muy vacio por aqui :|',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              );
            }
          }
          return Container();
          }
      )
    );
  }  
}

        /*builder: (context, AsyncSnapshot<List<PopularModel>?>snapshot) {
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

        */
