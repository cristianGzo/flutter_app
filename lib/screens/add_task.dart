import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/task_model.dart';

class addTask extends StatefulWidget {
  addTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  String? dropDownValue = "Pendiente";
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  List<String> dropDownValues = ['Pendiente','Completado', 'Proceso'];

  AgendaDB? agendaDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.taskModel != null) {
      txtConName.text = widget.taskModel!.nameTask!;
      txtConDsc.text = widget.taskModel!.dscTask!;
      switch (widget.taskModel!.sttTask) {
        case 'C': dropDownValue = "Completado"; break;
        case 'E': dropDownValue = "En proceso"; break;
        case 'P': dropDownValue = "Pendiente";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameTask = TextFormField(
      decoration:
          const InputDecoration(label: Text('Tarea'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtDscTask = TextField(
      decoration: const InputDecoration(
          label: Text('Description'), 
          border: OutlineInputBorder()),
      maxLines: 6,
      controller: txtConDsc,
    );
    

    final space = SizedBox(
      height: 10,);

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map((status) => DropdownMenuItem(value: status, 
        child: Text(status)
        )
        ).toList(), //el tatus trae los valores de la lista, completado etc.
      onChanged: (value) {
        dropDownValue = value;
        setState(() { });
      }
    );

    final ElevatedButton btnGuardar = ElevatedButton(
      onPressed: (){
        if (widget.taskModel == null) {
          agendaDB!.INSERT('tblTareas', {
            'nameTask': txtConName.text,
            'dscTask': txtConDsc.text,
            'sttTask': dropDownValue!.substring(0,1)
          }).then((value) {
            var msj =
                (value > 0) ? 'la insercion fue exitosa' : 'ocurrio un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context); //para regresar a la pantalla anterior cuando se hace la insercion
          });
        } else {
          agendaDB!.UPDATE('tblTareas', {
            'idTask': widget.taskModel!.idTask,
            'nameTask': txtConName.text,
            'dscTask': txtConDsc.text,
            'sttTask': dropDownValue!.substring(0,1)
          }).then((value) {
            GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
            var msj =
                (value > 0) ? 'la actualizacion fue exitosa' : 'ocurrio un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context); //para regresar a la pantalla anterior cuando se hace la insercion
          });
        }
      },
      child: Text('Save Task'),
    );

    return Scaffold(
      appBar: AppBar(
        title:
            widget.taskModel == null ? Text('Add Task') : Text('Update Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            txtNameTask,
            space,
            txtDscTask,
            space,
            ddBStatus,
            space,
            btnGuardar
          ],
        ),
      ),
    );
  }
}
