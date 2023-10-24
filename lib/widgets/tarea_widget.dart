import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/tarea_model.dart';
import 'package:flutter_app/screens/add_tarea.dart';
import 'package:intl/intl.dart';


class TareaWidget  extends StatelessWidget {
  TareaWidget ({super.key, required this.tareaModel, this.agendaDB});

  TareaModel tareaModel; //llaves indican que los parametros son nombrados
  AgendaDB? agendaDB;

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
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        
        child: Row(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Nombre:   ${tareaModel.nomTarea!}'), Text('Descripcion:   ${tareaModel.desTarea!}'),Text('Fecha expiracion:   ${tareaModel.fecExpiracion != null ? formatter.format(tareaModel.fecExpiracion!) : 'Sin fecha' }'), Text('Fecha recordatorio:   ${ tareaModel.fecRecordatorio != null ? formatter.format(tareaModel.fecRecordatorio!): 'Sin fecha'}'),
            Text('Estado:   ${estadoTarea(tareaModel.realizada)}')],
          ),
          Expanded(child: Container()), //es como espacio entre las columnas
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddTarea(tareaModel: tareaModel))),
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
                                      .DELETETAREA('Tarea', tareaModel.idTarea!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagTarea.value =
                                        !GlobalValues.flagTarea.value;
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
