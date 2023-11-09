import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/carrera_model.dart';
import 'package:flutter_app/widgets/carrera_widget.dart';

class CarreraScreen extends StatefulWidget {
  const CarreraScreen({super.key});

  @override
  State<CarreraScreen> createState() => _CarreraScreenState();
}

class _CarreraScreenState extends State<CarreraScreen> {
  AgendaDB? agendaDB;
  CarreraModel? carreraModel;

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Carreras',
        ),
        actions: [
          IconButton(
            onPressed: ()=> Navigator.pushNamed(context, '/addCarrera').then((value) { setState(() {});
            }
            ), 
            icon: Icon(Icons.add)
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable:
              GlobalValues.flagCarrera, //valor que se va estar monitoreando
          builder: (context, value, _) {
            return FutureBuilder(
                future: agendaDB!.GETALLCARRERA(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CarreraModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length, //snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                             return CarreraWidget(
                              carreraModel: snapshot.data![index], 
                              agendaDB: agendaDB,);

                        });
                  } else {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Error!'),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
                });
          }),
    );
  }
}