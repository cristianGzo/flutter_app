import 'package:flutter/material.dart';

class DashBooardScreen extends StatelessWidget {
  const DashBooardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos'),
      ),
      drawer: createDrawer(),
    );
  }

  Widget createDrawer(){
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: 
              NetworkImage('https://i.pravatar.cc/300'),
              ),
            accountName: Text('Rubensin'), 
            accountEmail: Text('isTorres@gmail.com')
          ),
          ListTile(
            leading: Image.network(''),
            trailing: Icon(Icons.chevron_right),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'),
            onTap: (){},
          )
         /* DayNightSwitcher(
  isDarkModeEnabled: isDarkModeEnabled,
  onStateChanged: (isDarkModeEnabled) {
    setState(() {
      this.isDarkModeEnabled = isDarkModeEnabled;
    });
  },
),*/
        ],
      ),
    );
  }
}