import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/assets/styles_app.dart';
import 'package:flutter_app/routes.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final prefs = snapshot.data as SharedPreferences;
          final isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
          GlobalValues.flagTheme.value = isDarkTheme;

          return ValueListenableBuilder(
            valueListenable: GlobalValues.flagTheme,
            builder: (context, value, _) {
              return MaterialApp(
                routes: getRoutes(),
                theme: value
                    ? StylesApp.darkTheme(context)
                    : StylesApp.lightTheme(context),
                home: isViewed != 0 ? OnBoard() : const LoginScreen(),
              );
            },
          );
        } else {
          return CircularProgressIndicator(); // Puedes mostrar un indicador de carga mientras se obtienen las preferencias.
        }
      },
    );
  }
}

//gestor de estados como: lgetx, bloc, provider, valueNotifier