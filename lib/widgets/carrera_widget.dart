import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/carrera_model.dart';
import 'package:flutter_app/screens/add_carrera.dart';

class CarreraWidget extends StatelessWidget {
  CarreraWidget({super.key, required this.carreraModel, this.agendaDB});

  CarreraModel carreraModel; //llaves indican que los parametros son nombrados
  AgendaDB? agendaDB;

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.only(top: 6),
        padding: EdgeInsets.all(6),
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Carrera:   ${carreraModel.nomCarrera}') ],
          ),
          Expanded(child: Container()), //es como espacio entre las columnas
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCarrera(carreraModel: carreraModel))),
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
                                      .DELETECARRERA('Carrera', carreraModel.idCarrera!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagCarrera.value =
                                        !GlobalValues.flagCarrera.value;
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