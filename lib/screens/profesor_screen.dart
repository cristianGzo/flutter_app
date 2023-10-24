import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/profesor_model.dart';
import 'package:flutter_app/widgets/profesor_widget.dart';

class ProfesorScreen extends StatefulWidget {
  const ProfesorScreen({super.key});

  @override
  State<ProfesorScreen> createState() => _ProfesorScreenState();
}

class _ProfesorScreenState extends State<ProfesorScreen> {
  AgendaDB? agendaDB;
  ProfesorModel? profesorModel;

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
          'Profesores',
        ),
        actions: [
          IconButton(
            onPressed: ()=> Navigator.pushNamed(context, '/addProfesor').then((value) { setState(() {});
            }
            ), 
            icon: Icon(Icons.login)
          )
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable:
              GlobalValues.flagProfe, //valor que se va estar monitoreando
          builder: (context, value, _) {
            return FutureBuilder(
                future: agendaDB!.GETALLPROFESOR(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ProfesorModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length, //snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                             return ProfesorWidget(
                              profesorModel: snapshot.data![index], 
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