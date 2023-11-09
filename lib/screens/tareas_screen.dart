import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/tarea_model.dart';
import 'package:flutter_app/search/search_tarea.dart';
import 'package:flutter_app/widgets/tarea_widget.dart';




class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  
  AgendaDB? agendaDB;
  TareaModel? tareaModel;
  List<TareaModel> tareas = [];

  @override
  void initState() {
    super.initState();
    agendaDB = AgendaDB();
    fetchTareas();
    
  }
  
   Future<void> fetchTareas() async {
    final tareasList = await agendaDB!.GETALLTAREA();
    setState(() {
      tareas = tareasList;
    });
  }
  String estadoTarea(int? valor) {
  if (valor == 1) {
    return 'Realizada';
  } else if (valor == 2) {
    return 'En Proceso';
  } else if (valor == 3) {
    return 'Pendiente';
  } else {
    return 'Desconocido'; 
  }
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tareas',
        ),
        actions: [
          IconButton(
            onPressed: ()=> Navigator.pushNamed(context, '/addTarea').then((value) { setState(() {});
            }
            ), 
            icon: Icon(Icons.task)
          ),
          IconButton(
            onPressed: ()=> showSearch(context: context, delegate: SearchTarea(tareas)), 
            icon: Icon(Icons.search)
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable:
              GlobalValues.flagTarea, //valor que se va estar monitoreando
          builder: (context, value, _) {
            
            return FutureBuilder(
                future: agendaDB!.GETALLTAREA(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<TareaModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length, //snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                             return TareaWidget(
                              tareaModel: snapshot.data![index], 
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