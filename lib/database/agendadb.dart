import 'dart:async';
import 'dart:io';
import 'package:flutter_app/models/carrera_model.dart';
import 'package:flutter_app/models/profesor_model.dart';
import 'package:flutter_app/models/tarea_model.dart';
import 'package:flutter_app/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AgendaDB{

  static final nameDB = 'AGENDADB1';
  static final versionDB = 2;

  static Database? _database;
  
  Future<Database?> get database async{
    if( _database != null) return _database!;
    return _database = await _initDatabase();
  }
  
  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(
      pathDB,
      version: versionDB,
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
    ); 
  }

  FutureOr<void> _createTables(Database db, int version) {
    //las ''' es la forma de indicar un query
    String query = '''CREATE TABLE tblTareas(
      idTask INTEGER PRIMARY KEY,
      nameTask VARCHAR(50),
      dscTask VARCHAR(50),
      sttTask BYTE
      );''';
      db.execute(query);
  }

  Future<void> _upgradeTables(Database db, int version, int newVersion) async {
  if (version < newVersion) {

    await db.execute('''
      CREATE TABLE Tarea(
        idTarea INTEGER PRIMARY KEY,
        nomTarea varchar(50),
        fecExpiracion DATETIME,
        fecRecordatorio DATETIME,
        desTarea varchar(120),
        realizada INTEGER,
        idProfe INTEGER,
        FOREIGN KEY (idProfe) references Profesor (idProfe));
    ''');
    await db.execute('''
      CREATE TABLE Profesor(
        idProfe INTEGER PRIMARY KEY,
        nomProfe varchar(50),
        idCarrera INTEGER,
        email varchar(50),
        FOREIGN KEY (idCarrera) references Carrera(idCarrera)
      );''');
      await db.execute('''
      CREATE TABLE Carrera(
        idCarrera INTEGER PRIMARY KEY,
        nomCarrera varchar(50));''');
  }
}


  Future<int> INSERT(String tblName, Map<String,dynamic> data ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.insert(tblName, data);
  }

  Future<int> UPDATE(String tblName, Map<String, dynamic> data ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.update(tblName, data, where: 'idTask = ?', whereArgs: [data['idTask']]); //consultas parametrizadas
  }
  Future<int> DELETE(String tblName, int idTask ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.delete(tblName, where: 'idTask = ?', whereArgs: [idTask]);
  }

  Future<List<TaskModel>> GETALLTASK() async{
    var conexion = await database;
    var result = await conexion!.query('tblTareas');
    return result.map((task)=>TaskModel.fromMap(task)).toList();
  }

  //******************************TAREA*************************************** */


  Future<List<TareaModel>> GETALLTAREA() async{
    var conexion = await database;
    var result = await conexion!.query('Tarea');
    return result.map((tarea)=>TareaModel.fromMap(tarea)).toList();
  }
  Future<int> UPDATETAREA(String tblName, Map<String, dynamic> data ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.update(tblName, data, where: 'idTarea = ?', whereArgs: [data['idTarea']]); //consultas parametrizadas
  }
  Future<int> DELETETAREA(String tblName, int idTarea ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.delete(tblName, where: 'idTarea = ?', whereArgs: [idTarea]);
  }



  //*****************************Profesor*******************************+ */
  Future<List<ProfesorModel>> GETALLPROFESOR() async{
    var conexion = await database;
    var result = await conexion!.query('Profesor');
    return result.map((profesor)=>ProfesorModel.fromMap(profesor)).toList();
  }
  Future<int> UPDATEPROFESOR(String tblName, Map<String, dynamic> data ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.update(tblName, data, where: 'idProfe = ?', whereArgs: [data['idProfe']]); //consultas parametrizadas
  }
  Future<int> DELETEPROFESOR(String tblName, int idProfe ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.delete(tblName, where: 'idProfe = ?', whereArgs: [idProfe]);
  }

  //*****************************Carrera************************************************ */
  Future<List<CarreraModel>> GETALLCARRERA() async{
    var conexion = await database;
    var result = await conexion!.query('Carrera');
    return result.map((carrera)=>CarreraModel.fromMap(carrera)).toList();
  }
  Future<int> UPDATECARRERA(String tblName, Map<String, dynamic> data ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.update(tblName, data, where: 'idCarrera = ?', whereArgs: [data['idCarrera']]); //consultas parametrizadas
  }
  Future<int> DELETECARRERA(String tblName, int idCarrera ) async { //int en esta linea, significa que del insert devolvera el id que es de tipo int
    var conexion = await database; //hace o verifica la conexion
    return conexion!.delete(tblName, where: 'idCarrera = ?', whereArgs: [idCarrera]);
  }
}