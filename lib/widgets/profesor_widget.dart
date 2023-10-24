import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/profesor_model.dart';
import 'package:flutter_app/screens/add_profesor.dart';

class ProfesorWidget extends StatelessWidget {
  ProfesorWidget({super.key, required this.profesorModel, this.agendaDB});

  ProfesorModel profesorModel; //llaves indican que los parametros son nombrados
  AgendaDB? agendaDB;


  String carrera(int? valor) {
  if (valor == 1) {
    return 'Industrial';
  } else if (valor == 2) {
    return 'Sistemas';
  } else {
    return 'Otra carrera';
  } 
}
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Profesor:   ${profesorModel.nomProfe!}'), Text('Email:   ${profesorModel.email!}'), Text('Carrera:   ${carrera(profesorModel.idCarrera)}')],
          ),
          Expanded(child: Container()), //es como espacio entre las columnas
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddProfesor(profesorModel: profesorModel))),
                child: Image.asset(
                  'assets/mango.png',
                  height: 50,
                )
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Mensaje del sistema"),
                          content: Text("Deseas eliminar el elemento"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  agendaDB!
                                      .DELETEPROFESOR('Profesor', profesorModel.idProfe!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagProfe.value =
                                        !GlobalValues.flagProfe.value;
                                  });
                                },
                                child: Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No')),
                          ],
                        );
                      });
                },
                icon: Icon(Icons.delete),
              )
            ],
          ),
        ])
    );
  }
}