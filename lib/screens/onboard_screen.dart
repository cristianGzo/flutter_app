import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/onboard_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoard extends StatefulWidget {
  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  int currentIndex = 0;
//implements TickerProvider {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConcentricPageView(
            colors: const [
          Color.fromARGB(255, 0, 0, 0),
          Color.fromARGB(255, 1, 0, 30),
          Colors.black
        ],
            physics: NeverScrollableScrollPhysics(),
            onChange: (page) {
              setState(() {
                currentIndex = page;
                if (currentIndex == 1) {
                  /* Navigator.pushNamed(context, '/login_screen');*/
                }
              });
            },
            itemBuilder: (int index) {
              return /*Center(
            child: Container(
              child: Text('screen $index'),
            ),
          );*/
                  /*Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              /*actions: [
          TextButton(
            onPressed: () async {
              await _StoreOnBoardInfo();
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              Navigator.pushNamed(context, '/login_screen');
            },
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],*/
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: PageView.builder(
                  itemCount: screen.length,
                  //controller: _pageController,
                  /*physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                      /*_textAnimationController
                    .reset(); // Reiniciar la animación al cambiar de página
                _textAnimationController.forward();*/
                    });
                  },*/
                  itemBuilder: (context, index) {*/
                  Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    screen[index].logo,
                    height: 80,
                    width: 80,
                  ),
                  /*Transform.scale(
              scale: .2,
              child: Image.asset('../../assets/images/logo_dark.png'),  ),*/
                  Text(
                    screen[index].txtSup,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Image.asset(
                    screen[index].imag,
                    height: 250,
                    width: 250,
                  ),
                  Text(
                    screen[index].txt,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    screen[index].desc,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    height: 10.0,
                    child: ListView.builder(
                        itemCount: screen.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 3.0),
                                width: currentIndex == index ? 25.0 : 8.0,
                                height: 8,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ],
                          );
                        }),
                  ),

                  /*SlideTransition(
                    position: _textSlideAnimation,
                    child: Text(
                      screen[index].txt,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SlideTransition(
                    position: _textSlideAnimation,
                    child: Text(
                      screen[index].desc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),*/
                  /*  InkWell(
                    onTap: () async {
                      if (index == screen.length - 1) {
                        await _StoreOnBoardInfo();
                        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        Navigator.pushNamed(context, '/login_screen');
                      }

                      _pageController.nextPage(
                        duration: const Duration(microseconds: 300),
                        curve: Curves.bounceIn,
                      );
                    },
                    //button next
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 4.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(22.0)),
                      child:
                          const Row(mainAxisSize: MainAxisSize.min, children: [
                        Text(
                          "Next",
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        SizedBox(width: 15.0),
                        Icon(Icons.arrow_forward_sharp, color: Colors.white),
                      ]),
                    ),
                  ),
                
                */
                ],
              );
            },
            onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
            )
            );
  }
}
