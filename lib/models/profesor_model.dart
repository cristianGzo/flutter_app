class ProfesorModel{
  int? idProfe;
  String? nomProfe;
  int? idCarrera; 
  String? email;


  ProfesorModel({this.idProfe, this.nomProfe, this.idCarrera, this.email});


  factory ProfesorModel.fromMap(Map<String,dynamic> map) {
    int? carrera;

if (map['idCarrera'] is int) {
  carrera = map['idCarrera'];
} else if (map['idCarrera'] is String) {
  carrera = int.tryParse(map['idCarrera']);
}
     return ProfesorModel(
      idProfe: map['idProfe'],
      nomProfe: map['nomProfe'],
      idCarrera: carrera,
      email: map['email']
      );
  }
}