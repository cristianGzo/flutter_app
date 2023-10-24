import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/database/agendadb.dart';
import 'package:flutter_app/models/tarea_model.dart';
import 'package:intl/intl.dart';



class AddTarea extends StatefulWidget {
  AddTarea({super.key, this.tareaModel});

  TareaModel? tareaModel;

  @override
  State<AddTarea> createState() => _AddTareaState();
}

class _AddTareaState extends State<AddTarea> {
   
  String? dropDownValue = "Pendiente";
  TextEditingController txtConName = TextEditingController();
  TextEditingController txtConDsc = TextEditingController();
  TextEditingController txtRecordatorio = TextEditingController();
  TextEditingController txtExpiracion = TextEditingController();
  List<String> dropDownValues = ['Pendiente','Realizada', 'En proceso'];
  int nums=1;

  AgendaDB? agendaDB;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    agendaDB = AgendaDB();
    if (widget.tareaModel != null) {
      txtConName.text = widget.tareaModel!.nomTarea!;
      txtConDsc.text = widget.tareaModel!.desTarea!;


      //txtRecordatorio.text = widget.tareaModel!.fecRecordatorio!.toString();
      //txtExpiracion.text = widget.tareaModel!.fecExpiracion!.toString();
      String fechaFormateada = widget.tareaModel!.fecExpiracion != null
      ? DateFormat('y-MM-dd').format(widget.tareaModel!.fecExpiracion!)
      : '';
      txtExpiracion.text = fechaFormateada;
      String fechaF = widget.tareaModel!.fecRecordatorio!= null
      ? DateFormat('y-MM-dd').format(widget.tareaModel!.fecRecordatorio!)
      : '';
      txtExpiracion.text = fechaF;
      switch (widget.tareaModel!.realizada) {
        case 1: dropDownValue = "Realizada"; break;
        case 2: dropDownValue = "En proceso"; break;
        case 3: dropDownValue = "Pendiente";
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final txtNameTarea = TextFormField(
      decoration:
          const InputDecoration(label: Text('Tarea'), border: OutlineInputBorder()),
      controller: txtConName,
    );

    final txtDscTarea = TextField(
      decoration: const InputDecoration(
          label: Text('Description'), 
          border: OutlineInputBorder()),
      maxLines: 4,
      controller: txtConDsc,
    );
    final txtRecord = TextFormField(
      decoration:
          const InputDecoration(label: Text('Recordatorio'), border: OutlineInputBorder()),
      controller: txtRecordatorio,
    );
    final txtExp = TextFormField(
      decoration:
          const InputDecoration(label: Text('Expiracion'), border: OutlineInputBorder()),
      controller: txtExpiracion,
    );
    

    final DropdownButton ddBStatus = DropdownButton(
      value: dropDownValue,
      items: dropDownValues.map((status) => DropdownMenuItem(value: status, 
        child: Text(status)
        )
        ).toList(), //el tatus trae los valores de la lista, completado etc.
      onChanged: (value) {
        dropDownValue = value;
        nums = estado(value);
        setState(() { });
      }
    );
      final space = SizedBox(
      height: 10,);

    final ElevatedButton btnGuardar = ElevatedButton(
      onPressed: (){
        
        if (widget.tareaModel == null) {
          agendaDB!.INSERT('Tarea', {
            'nomTarea': txtConName.text,
            'desTarea': txtConDsc.text,
            'fecExpiracion': txtExpiracion.text,
            'fecRecordatorio': txtRecordatorio.text,
            'realizada': nums,
          }).then((value) {
            var tareaModel = TareaModel(  // Declarar tareaModel aquí
          nomTarea: txtConName.text,
          desTarea: txtConDsc.text,
          fecExpiracion: DateTime.parse(txtExpiracion.text),
          fecRecordatorio: DateTime.parse(txtRecordatorio.text),
          realizada: nums,
        );

            var msj =
                (value > 0) ? 'la insercion fue exitosa' : 'ocurrio un error';
            var snackbar = SnackBar(content: Text(msj));
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            Navigator.pop(context); //para regresar a la pantalla anterior cuando se hace la insercion
          });
        } else {
          agendaDB!.UPDATETAREA('Tarea', {
            'idTarea': widget.tareaModel!.idTarea,
            'nomTarea': txtConName.text,
            'desTarea': txtConDsc.text,
            'fecRecordatorio': txtRecordatorio.text,
            'fecExpiracion': txtExpiracion.text,
            'realizada': nums,

          }).then((value) {
            GlobalValues.flagTarea.value = !GlobalValues.flagTarea.value;
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
            widget.tareaModel == null ? Text('Add Tarea') : Text('Actualizar Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
        
            children: [
              txtNameTarea,
              space,
              txtDscTarea,
              space,
              txtRecord,
              space,
              txtExp,
              space,
              ddBStatus,
              space,
              btnGuardar
            ],
          ),
        ),
      ),
    );
  }
  /*
  Future<void> scheduleNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      TareaModel tareaModel) async {
        tz.initializeTimeZones();
    final DateTime recordatorio = tareaModel.fecRecordatorio ?? DateTime.now();
    final tz.TZDateTime scheduledDate = tz.TZDateTime(tz.local, recordatorio.year, recordatorio.month, recordatorio.day, 12, 0);
    //.from(recordatorio, tz.local);
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'TareaRecordatorio',
      'TareaRecordatorio',
      'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
     NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    
    // Programe la notificación
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Recordatorio de tarea',
      'Recuerda tu tarea: ${tareaModel.nomTarea}',scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,payload: 'custom notification payload',
    );
  }*/
  int estado(String estado) {
  switch (estado) {
    case 'Realizada':
      return 1;
    case 'En proceso':
      return 2;
    case 'Pendiente':
      return 3;
    default:
      return 0; // Valor predeterminado o valor para casos desconocidos
  }
}
}