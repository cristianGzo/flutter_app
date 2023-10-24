import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/profesor_model.dart';

class AddProfesor extends StatefulWidget {
  AddProfesor({super.key, this.profesorModel});

  ProfesorModel? profesorModel;

  @override
  State<AddProfesor> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<AddProfesor> {

  TextEditingController txtName = TextEditingController();
  TextEditingController txtCorreo = TextEditingController();
  TextEditingController txtCarrera = TextEditingController();
  int nums=1;
  AgendaDB? agendaDB;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.profesorModel != null) {
      txtName.text = widget.profesorModel!.nomProfe!;
      txtCorreo.text = widget.profesorModel!.email!;
      Map<int, String> carreraMap = {
        1: "Industrial",
        2: "Sistemas",
        0: "OtraCarrera" // Agrega otras opciones aquí si es necesario
      };

    txtCarrera.text = carreraMap[widget.profesorModel!.idCarrera] ?? "Carrera Desconocida";
    }
  }

  @override
  Widget build(BuildContext context) {
     final txtNameProfe = TextFormField(
      decoration:
          const InputDecoration(label: Text('Profesor'), border: OutlineInputBorder()),
      controller: txtName,
    );
    final txtCorreoProfe = TextFormField(
      decoration:
          const InputDecoration(label: Text('Email'), border: OutlineInputBorder()),
      controller: txtCorreo,
    );
    final txtCarr = TextFormField(
      decoration:
          const InputDecoration(label: Text('Carrera'), border: OutlineInputBorder()),
      controller: txtCarrera,
    );
    final space = SizedBox(
      height: 10,);

      final ElevatedButton btnGuardar = ElevatedButton(
      onPressed: (){
        
        if (widget.profesorModel == null) {
          agendaDB!.INSERT('Profesor', {
            'nomProfe': txtName.text,
            'email': txtCorreo.text,
            'idCarrera': nums=carrera(txtCarrera.text)
          }).then((value) {
            var msj =
                (value > 0) ? 'la insercion fue exitosa' : 'ocurrio un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context); //para regresar a la pantalla anterior cuando se hace la insercion
          });
        } else {
          agendaDB!.UPDATEPROFESOR('Profesor', {
            'idProfe': widget.profesorModel!.idProfe,
            'nomProfe': txtName.text,
            'email': txtCorreo.text,
            'idCarrera': nums=carrera(txtCarrera.text)

          }).then((value) {
            GlobalValues.flagProfe.value = !GlobalValues.flagProfe.value;
            var msj =
                (value > 0) ? 'la actualizacion fue exitosa' : 'ocurrio un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context); //para regresar a la pantalla anterior cuando se hace la insercion
          });
        }
      },
      child: Text('Save Profesor'),
      
    );

    return Scaffold(
      appBar: AppBar(
        title:
            widget.profesorModel == null ? Text('Add Profesor') : Text('Actualizar Profesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
        
            children: [
              txtNameProfe,
              space,
              txtCorreoProfe,
              space,
              txtCarr,
              space,
              btnGuardar
            ],
          ),
        ),
      ),
    );
  }
  int carrera(String carrera) {
  switch (carrera) {
    case 'Industrial':
      return 1;
    case 'Sistemas':
      return 2;
    default:
      return 0; // Valor predeterminado o valor para casos desconocidos
  }
}
}