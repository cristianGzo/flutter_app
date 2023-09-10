import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/assets/styles_app.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/screens/carousel_image.dart';

int? isViewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  runApp(const MyApp());
}

//se crearon carpetas
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.flagTheme,
        builder: (context, value, _) {
          return MaterialApp(
            /*routes: {
            '/ : (BuildContext context) => LoginScreen()    <-- ejemplo de ruta inscrustada dentro de este mismo archivo
          }*/
            
            routes: getRoutes(),
            theme: value
                ? StylesApp.darkTheme(context)
                : StylesApp.lightTheme(context),
            home: isViewed != 0 ? OnBoard() : const LoginScreen(),
          );
        });
  }
}

//gestor de estados como: lgetx, bloc, provider, valueNotifier