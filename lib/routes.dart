
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/add_task.dart';
import 'package:flutter_app/screens/dashboard_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/task_screem.dart';

Map<String,WidgetBuilder> getRoutes(){
  return{
    '/dash' : (BuildContext context) => DashBooardScreen(),
    '/login_screen' : (BuildContext context) => LoginScreen(),
    '/add' : (BuildContext context) => addTask(),
    '/task' : (BuildContext context)=> TaskScreen(),
  };
}