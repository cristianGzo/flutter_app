import 'package:flutter/material.dart';

class GlobalValues{
  //eta variable se le podra hacer referencia donde sea, se  monitorea cuando hay cambios en el materialApp
// es como  si fuera un listenner que identifica los cambios y devuelve el valor
  static ValueNotifier<bool> flagTheme= ValueNotifier<bool> (true);

}