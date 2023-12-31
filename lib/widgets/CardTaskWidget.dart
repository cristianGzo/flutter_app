//import 'dart:ffi';
//import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/task_model.dart';
import 'package:flutter_app/screens/add_task.dart';

class CardTaskWidget extends StatelessWidget {
  CardTaskWidget({super.key, required this.taskModel, this.agendaDB});

  TaskModel taskModel; //llaves indican que los parametros son nombrados
  AgendaDB? agendaDB;

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
            children: [Text(taskModel.nameTask!), Text(taskModel.dscTask!)],
          ),
          Expanded(child: Container()), //es como espacio entre las columnas
          Column(
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => addTask(taskModel: taskModel))),
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
                                      .DELETE('tblTareas', taskModel.idTask!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagTask.value =
                                        !GlobalValues.flagTask.value;
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
