
import 'package:flutter/material.dart';
//todas las variables tienen aqui escuchadores para notificar cuando cambia la variable y notificar los cambios donde se utilice esa variable.
class TestProvider with ChangeNotifier{
  String _user='';// provider normalmente se usa con variables privadas
  String get user => _user;
  set user(String value){
    this._user=value;
    notifyListeners();
  }

}