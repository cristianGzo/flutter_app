import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/assets/global_values.dart';
import 'package:flutter_app/screens/carousel_image.dart';
import 'package:flutter_app/screens/counter.dart';
import 'package:flutter_app/screens/counter.dart';

class DashBooardScreen extends StatefulWidget {
  DashBooardScreen({super.key});

  @override
  State<DashBooardScreen> createState() => _DashBooardScreenState();
}

class _DashBooardScreenState extends State<DashBooardScreen> {
  bool _isFavorited = true;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 23, 36, 53),
          leading: Row(
            children: <Widget>[
              SizedBox(
                width: 5.0,
              ),
              IconButton(
                color: Colors.white,
                icon: const Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {},
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            SizedBox(
              width: 20.0,
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                CarouselWithIndicatorDemo(),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(
                          255, 23, 36, 53), //--------------------------------
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(50.0),
                        topRight: const Radius.circular(50.0),
                      )),
                  height: 500.0,
                  width: 500.0,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(
                            height: 20.0,
                          ),
                          const Text(
                            'Alumno',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text(
                            '1 each',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          CounterDesign(),
                          const Text(
                            'Running',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Text(
                            'Felicidades el dia de hoy superaste tu record haz lorado recorrer 5km en tan solo 30 minutos, tu progreso es excelente.',
                            style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 15.0,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: <Widget>[
                              ButtonTheme(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Colors.blue[200] ??
                                          Colors.transparent),
                                ),
                                height: 70.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    primary: Colors.white,
                                  ),
                                  child: IconButton(
                                    icon: _isFavorited
                                        ? Icon(
                                            Icons.favorite_border,
                                            color: Colors.blue[300],
                                          )
                                        : Icon(
                                            Icons.favorite,
                                            color: Colors.amber[300],
                                          ),
                                    onPressed: () {},
                                  ),
                                  onPressed: _toggleFavorite,
                                ),
                              ),
                              Image.asset('../../assets/grafico.png',
                                  height: 180.0, width: 190.0),

                              /* ButtonTheme(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                height: 70.0,
                                minWidth: 260.0,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    primary: Colors.blue[300],
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    'Add to cart',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),*/
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: createDrawer(),
      ),
    );
  }

  Widget createDrawer() {
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
            leading: Image.network(''),
            trailing: Icon(Icons.chevron_right),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'),
            onTap: () {},
          ),
          DayNightSwitcher(
            isDarkModeEnabled: GlobalValues.flagTheme.value,
            onStateChanged: (isDarkModeEnabled) {
              setState(() {
                GlobalValues.flagTheme.value = isDarkModeEnabled;
              });
            },
          ),
        ],
      ),
    );
  }
}
//al cambiar el stalessWiget por un statefullWidget 
