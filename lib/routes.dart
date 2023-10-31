
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/add_carrera.dart';
import 'package:flutter_app/screens/add_profesor.dart';
import 'package:flutter_app/screens/add_tarea.dart';
import 'package:flutter_app/screens/add_task.dart';
import 'package:flutter_app/screens/carrera_screen.dart';
import 'package:flutter_app/screens/dashboard_screen.dart';
import 'package:flutter_app/screens/detail_movie_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/opciones_screen.dart';
import 'package:flutter_app/screens/popular_screen.dart';
import 'package:flutter_app/screens/profesor_screen.dart';
import 'package:flutter_app/screens/provider_screen.dart';
import 'package:flutter_app/screens/tareas_screen.dart';
import 'package:flutter_app/screens/task_screem.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext context) => DashBooardScreen(),
    '/login_screen' : (BuildContext context) => LoginScreen(),
    '/add' : (BuildContext context) => addTask(),
    '/task' : (BuildContext context) => TaskScreen(),
    '/popuScreen': (BuildContext context) => PopularScreen(),
    '/opc' : (BuildContext context) => OpcionesScreen(),
    //'/detail': (BuildContext context) => DetailMovieScreen(),
    '/provider' : (BuildContext context) => ProviderScreen(),
    '/tareas': (BuildContext context) => TareasScreen(),
    '/addTarea': (BuildContext context) => AddTarea(), 
    '/addProfesor' : (BuildContext context) => AddProfesor(),
    '/maestros' : (BuildContext context) => ProfesorScreen(),
    '/carrera' : (BuildContext context) => CarreraScreen(),
    '/addCarrera' : (BuildContext context) => AddCarrera(),
    
  };
}