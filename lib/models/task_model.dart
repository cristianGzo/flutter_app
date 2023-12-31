class TaskModel {
  int? idTask;
  String? nameTask;
  String? dscTask;
  String? sttTask;

  TaskModel(
      {this.sttTask,
      this.idTask,
      this.nameTask,
      this.dscTask
      }); //este es un constructor. Sin las llaves son parametros indexados osea que deben estar en ese orden cuando se trabaje con el contructor y los nombrados no importa el orden como en este caso

  factory TaskModel.fromMap(Map<String,dynamic> map) {
    return TaskModel(
      idTask: map['idTask'],
      dscTask: map['dscTask'],
      nameTask: map['nameTask'],
      sttTask: map['sttTask']
      );
  }
}
