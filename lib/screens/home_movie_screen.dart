import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/favorite_screen.dart';
import 'package:flutter_app/screens/popular_screen.dart';


class HomeMovieScreen extends StatefulWidget {
  const HomeMovieScreen({super.key});

  @override
  State<HomeMovieScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeMovieScreen> {
  List<Widget> _screen = <Widget>[
    PopularScreen(),
    FavoriteScreen(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: _selectedIndex == 0 ? true : false,
      extendBody: true,
      backgroundColor: Colors.black87,
      body: _screen.elementAt(_selectedIndex),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                )
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              elevation: 0,
              unselectedItemColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}