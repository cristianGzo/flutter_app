import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/carrera_model.dart';

class AddCarrera extends StatefulWidget {
  AddCarrera({super.key, this.carreraModel});
   
   CarreraModel? carreraModel;

  @override
  State<AddCarrera> createState() => _AddCarreraState();
}

class _AddCarreraState extends State<AddCarrera> {

  TextEditingController txtCarrera = TextEditingController();
  
  int nums=1;
  AgendaDB? agendaDB;
  @override
  void initState() {
    
    super.initState();
    agendaDB = AgendaDB();
    if (widget.carreraModel != null) {
      txtCarrera.text = widget.carreraModel!.nomCarrera!;
     
   }
  }
  
  @override
  Widget build(BuildContext context) {
    final txtNameCarrera = TextFormField(
      decoration:
          const InputDecoration(label: Text('Profesor'), border: OutlineInputBorder()),
      controller: txtCarrera,
    );
    final space = SizedBox(
      height: 10,);

    final ElevatedButton btnGuardar = ElevatedButton(
      onPressed: (){
        
        if (widget.carreraModel == null) {
          agendaDB!.INSERT('Carrera', {
            'nomCarrera': txtCarrera.text,
          }).then((value) {
            var msj =
                (value > 0) ? 'la insercion fue exitosa' : 'ocurrio un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context); //para regresar a la pantalla anterior cuando se hace la insercion
          });
        } else {
          agendaDB!.UPDATECARRERA('Carrera', {
            'idCarrera': widget.carreraModel!.idCarrera,
            'nomCarrera': txtCarrera.text,
          }).then((value) {
            GlobalValues.flagCarrera.value = !GlobalValues.flagCarrera.value;
            var msj =
                (value > 0) ? 'la actualizacion fue exitosa' : 'ocurrio un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context); //para regresar a la pantalla anterior cuando se hace la insercion
          });
        }
      },
      child: Text('Save Carrera'),
      
    );

    return Scaffold(
      appBar: AppBar(
        title:
            widget.carreraModel == null ? Text('Add Carrera') : Text('Actualizar Carrera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
        
            children: [
              txtNameCarrera,
              space,
              btnGuardar
            ],
          ),
        ),
      ),
    );
  }
}