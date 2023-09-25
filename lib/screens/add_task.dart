import 'package:flutter/material.dart';
import 'package:flutter_app/database/agendadb.dart';

class addTask extends StatefulWidget {
  const addTask({super.key});

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  TextEditingController txtConDsc = TextEditingController();
  TextEditingController txtConName = TextEditingController();
  String dropDownValue = "Pendiente";
  List<String> dropDownValues = ['Completado', 'Proceso', 'Pendiente'];


  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
  }

  @override
  Widget build(BuildContext context) {
    final txtNameTask = TextFormField(
      decoration:
          InputDecoration(label: Text('Tarea'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtDscTask = TextFormField(
      decoration: InputDecoration(
          label: Text('Description'), border: OutlineInputBorder()),
      maxLines: 6,
      controller: txtConDsc,
    );

    final space = SizedBox(
      height: 10,
    );

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValues,
      items: dropDownValues
          .map((status) => DropdownMenuItem(value: status, child: Text(status)))
          .toList(), //el tatus trae los valores de la lista, completado etc.
      onChanged: (value) {
        dropDownValue = value;
        setState(() {});
      },
    );

    final ElevatedButton btnGuardar = ElevatedButton(
      onPressed: () {
        agendaDB!.INSERT('tblTareas', {
          'nameTask': txtConName, 
          'dscTask': txtConDsc, 
          'sttTask': dropDownValue.substring(1,1) }).then((value) {
            var msj= (value>0)
            ? 'la insercion fue exitosa'
            :'ocurrio un error';
            var snackbar= SnackBar(content: Text(msj));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          Navigator.pop(context);//para regresar a la pantalla anterior cuando se hace la insercion
          });
      },
      child: Text('Save Task'),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
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
