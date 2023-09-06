import 'package:flutter/material.dart';

class onboardModel {
  String logo;
  String txtSup;
  String imag;
  String txt;
  String desc;
  Color bg;
  Color btn; 
  Color? btn1;

  onboardModel({
    required this.logo,
    required this.txtSup,
    required this.imag,
    required this.txt,
    required this.desc,
    required this.bg,
    required this.btn,
    this.btn1
  });

}

List <onboardModel> screen = <onboardModel>[
  onboardModel(
    logo: '../../assets/logo.png',
    txtSup: 'Sistema lince app movil',
    imag: '../../assets/tec.webp',
    txt: 'Bienvenidos a lince app',
    desc: "Es un sistema de la ingeniería en sistemas computacionales del Tecnológico Nacional de México en Celaya",
    bg: Colors.white,
    btn: const Color(0XFF4756DF),
  ),
  onboardModel(
    logo: '../../assets/logo.png',
    txtSup: 'Sistema lince app movil',
    imag: '../../assets/ISC.jpg',
    txt: '¿De qué trata el lince app?',
    desc: "Llevar el control de los lince sistematicos para que se diviertan en sus momentos libres",
    bg: Colors.white,
    btn: const Color(0XFFF8BBD0)
  ),
  onboardModel(
    logo: '../../assets/logo.png',
    txtSup: 'Sistema lince app movil',
    imag: '../../assets/lince.png',
    txt: 'Vamos a comenzar',
    desc: "Muy bien lince, comencemos, puedes iniciar sesion para entrar a la app.",
    bg: Colors.white,
    btn: const Color(0XFFF8BBD0),
    btn1: Colors.green
  ),
];
