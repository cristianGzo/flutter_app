class TareaModel{
  int? idTarea;
  String? nomTarea;  
  DateTime? fecExpiracion;
  DateTime? fecRecordatorio;
  String? desTarea;
  int? realizada;
  int? idProfe;

  TareaModel({this.idTarea, this.nomTarea, this.fecExpiracion, this.fecRecordatorio, this.desTarea, this.realizada, this.idProfe});


  factory TareaModel.fromMap(Map<String,dynamic> map) {
    
  
  String fechaExpiracionStr = map['fecExpiracion'];
  String fechaRecordatorioStr = map['fecRecordatorio'];

  DateTime? fechaExpiracion;
  DateTime? fechaRecordatorio;

  if (fechaExpiracionStr != null) {
    List<String> partes = fechaExpiracionStr.split('-');

    if (partes.length == 3) {
      int year = int.parse(partes[0]);
      int month = int.parse(partes[1]);
      int day = int.parse(partes[2].split(' ')[0]);
      fechaExpiracion = DateTime(year, month, day);
    }
  }

  if (fechaRecordatorioStr != null) {
    List<String> partes = fechaRecordatorioStr.split('-');

    if (partes.length == 3) {
      int year = int.parse(partes[0]);
      int month = int.parse(partes[1]);
      int day = int.parse(partes[2].split(' ')[0]);
      fechaRecordatorio = DateTime(year, month, day);
    }
  }
    int? realizada;

if (map['realizada'] is int) {
  realizada = map['realizada'];
} else if (map['realizada'] is String) {
  realizada = int.tryParse(map['realizada']);
}
    return TareaModel(
      idTarea: map['idTarea'],
      nomTarea: map['nomTarea'],
      fecExpiracion: fechaExpiracion,
      fecRecordatorio: fechaRecordatorio,
      desTarea: map['desTarea'],
      realizada: realizada,
      idProfe: map['idProfe']
      );
      //aqui las propiedades (las del laado derecho) deben ser igual al nombre de los campos de la base de datos
  }

}