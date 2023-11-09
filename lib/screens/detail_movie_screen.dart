import 'package:flutter/material.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/favorite_model.dart';
import 'package:flutter_app/widgets/CardActor.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_app/models/actor_model.dart';
import 'package:flutter_app/models/popular_model.dart';
import 'package:flutter_app/network/api_popular.dart';
import 'package:flutter_app/provider/test_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:provider/provider.dart';

class DetailMovieScreen extends StatefulWidget {
  final PopularModel? model;
  final int? id;
  DetailMovieScreen.model({Key? key, required this.model})
      : id = null,
        super(key: key);

  // Constructor que recibe un ID
  DetailMovieScreen.id({Key? key, required this.id})
      : model = null,
        super(key: key);

//final int id;

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  final ApiPopular apiPopular = ApiPopular();
  late bool fav = false;
  @override
void initState() {
  super.initState();
  loadFavorites(); // Llama a la función para cargar los favoritos
}

// Nueva función asincrónica para cargar los favoritos
Future<void> loadFavorites() async {
  List<FavoriteModel> favorites = await AgendaDB().GETFAV();
  bool isFavorite = favorites.any((favorite) => favorite.id == widget.model?.id);
  setState(() {
    fav = isFavorite;
  });
}
  /*PopularModel? movie;
  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context)!.settings.arguments as PopularModel;   //con esto se recupera entre pantallas el elemento que se envia
    return Scaffold(
      body: Center(child: Text(movie!.title!)),
    );
  }*/
  @override
  Widget build(BuildContext context) {
    TestProvider flag = Provider.of<TestProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Hero(
        tag: widget.model?.id?.toString() ?? '',
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://image.tmdb.org/t/p/w500/${widget.model?.backdropPath ?? ''}'),
                        fit: BoxFit.fitHeight,
                        opacity: 0.3)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          widget.model?.title.toString() ?? 'no disponible',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            height: 200,
                            width: 100,
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${widget.model?.posterPath}'),
                          ),
                          Container(
                            child: RatingBar(
                              initialRating: (widget.model?.voteAverage ?? 0) / 2,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star,
                                      color: Color.fromARGB(255, 255, 238, 0)),
                                  half: const Icon(
                                    Icons.star_half,
                                    color: Color.fromARGB(255, 255, 238, 0),
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline,
                                    color: Color.fromARGB(255, 255, 238, 0),
                                  )),
                              ignoreGestures: true,
                              onRatingUpdate: (value) {},
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Sinopsis',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(), // Agrega espacio entre el texto y el icono
                          IconButton(
                            onPressed: () async {
                              bool isFavorite = await addOrRemoveFavorite();
                              setState(() {
                                fav = isFavorite;
                              });
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: fav ? Colors.red : Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          widget.model?.overview.toString() ?? '',
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                        future: apiPopular.getVideo(widget.model?.id ?? 0),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return YoutubePlayer(
                              controller: YoutubePlayerController(
                                  initialVideoId: snapshot.data.toString(),
                                  flags: const YoutubePlayerFlags(
                                    autoPlay: false,
                                    mute: true,
                                    captionLanguage: AutofillHints.countryName,
                                  )),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Actores',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      FutureBuilder<List<ActorModel>?>(
                        future: widget.model != null
                            ? apiPopular.getAllActors(widget.model!) : null, // Verificamos si widget.model no es nulo
                        builder: (context, snapshot) {
                          if (widget.model == null) {
                            // Aquí puedes manejar el caso en el que widget.model sea nulo
                            return Text('El modelo es nulo');
                          }
                          if (snapshot.hasData && snapshot.data != null) {
                            return SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  ActorModel actor = snapshot.data![index];
                                  return CardActor(
                                    name: actor.name.toString(),
                                    photo: actor.profilePath != null
                                        ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                                        : 'https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg',
                                    character: actor.character!,
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> addOrRemoveFavorite() async {
    AgendaDB agendaDB = AgendaDB();
    List<FavoriteModel> favorites = await agendaDB.GETFAV();
    final int movieId = widget.model?.id ?? 0;

    //if (favorites.any((favorite) => favorite.id == widget.model?.id)) {
      if (favorites.any((favorite) => favorite.id == movieId)) {
      // La película ya está en favoritos, la eliminamos.
      //await agendaDB.DeleMovie(widget.model?.id! ?? 0);
      await agendaDB.DeleMovie(movieId);
      
      return false;
    } else {
      // La película no está en favoritos, la agregamos.
      Map<String, dynamic> data = {
        'id_movie': widget.model?.id,
        'posterPath': widget.model?.posterPath,
      };
      await agendaDB.INSERT("tblFav", data);
      return true;
    }
  }
}
