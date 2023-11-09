import 'package:flutter/material.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/favorite_model.dart';
import 'package:flutter_app/widgets/widget_favorite.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});
  AgendaDB agendaDB = AgendaDB();

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List<FavoriteModel> listFav;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initData(),
      builder: (context, AsyncSnapshot<dynamic> snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
          {
            return const Center(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  )));
          }
          case ConnectionState.done:
          {
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              child: ListView(children: [
                const Padding(padding: EdgeInsets.only(bottom: 10),
                child: Text("Peliculas favoritas",
                style: TextStyle(color: Colors.white, fontSize: 18),
                ),),
                listFav.isEmpty ? Center(
                  child: Column(children: [const Text("Sin favoritos", style: TextStyle(color: Colors.white),),
                  Image.asset("assets/tec.webp", width: 400, height: 400,
                  fit: BoxFit.fill,
                  )
                  ]),
            )
            :GridView.builder(
              shrinkWrap: true , padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (MediaQuery.of(context).size.width ~/ 170).toInt(),
            childAspectRatio: .9,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10),
            itemCount: listFav.length,
            itemBuilder: (context, index) {
              return WidgetFavorite(
                favoriteModel: listFav[index]);
                
            },
            )
              ]),
            );
          }
        }
      });
  }
  Widget getFavorite(){
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: ListView(children: [
        const Padding(padding: EdgeInsets.only(bottom: 10),
        child: Text("Peliculas Favoritas",
        style: TextStyle(color: Colors.white, fontSize: 18),),),
        listFav.isEmpty ? Center(
          child: Column(children: [
            const Text("Sin favoritos",
            style: TextStyle(color: Colors.white),),
            Image.asset("tec.webp",
            width: 400,
            height: 400,
            fit: BoxFit.fill,)
      ]),
    )
    : GridView.builder(shrinkWrap: true , padding: EdgeInsets.all(10),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
    childAspectRatio: .9,
    mainAxisSpacing: 10,
    crossAxisSpacing: 10),
    itemCount: listFav.length,
    itemBuilder: (context, index) {
      return /*ItemFavorite(favoriteModel: listFav[index]);*/
      Container();
    }
    ,)
    ]),
    );
  }
  initData() async {
    listFav = await widget.agendaDB.GETFAV();
  }
}