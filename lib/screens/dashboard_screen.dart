import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/assets/styles_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBooardScreen extends StatefulWidget {
  DashBooardScreen({super.key});

  @override
  State<DashBooardScreen> createState() => _DashBooardScreenState();
}

class _DashBooardScreenState extends State<DashBooardScreen> {


  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionSaved');
    Navigator.pushReplacementNamed(context, '/login_screen');
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos!!'),
      ),
      drawer: createDrawer(context),
    );
  }

  Widget createDrawer(context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
              ),
              accountName: Text('Rubensin'),
              accountEmail: Text('isTorres@gmail.com')),
          ListTile(
            leading: Image.network('../../assets/mango.png'),
            trailing: Icon(Icons.chevron_right),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.task_alt_outlined),
            trailing: Icon(Icons.chevron_right),
            title: Text('Task Manager'),
            onTap: () => Navigator.pushNamed(context, '/task'),
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) {
              GlobalValues.flagTheme.value = isDarkModeEnabled;
              StylesApp.saveTheme(isDarkModeEnabled);
            },
          ),
          ListTile(
            leading: Icon(
                Icons.logout), // Ícono de cerrar sesión o foto relacionada xd
            title: Text('Cerrar sesión'),
            onTap: () {
              logout(); // Llama a la función logout al hacer clic en "Cerrar sesión"
            }),
        ],
      ),
    );
  }
}
//al cambiar el stalessWiget por un statefullWidget 
