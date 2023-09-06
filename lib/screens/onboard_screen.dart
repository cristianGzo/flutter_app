import 'package:flutter/material.dart';
import 'package:flutter_app/models/onboard_model.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }

  int currentIndex = 0;
  late PageController _pageController;
//ctrl de animacion
  late AnimationController _textAnimationController;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _textAnimationController = AnimationController(
      duration: const Duration(seconds: 1), // Duración de la animación
      vsync: this,
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0), // Posición inicial
      end: const Offset(0.0, 0.0), // Posición final en el centro de la pantalla
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves
          .easeInOut, // Curva de animación (puedes ajustarla según tus preferencias)
    ));
    _textAnimationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  _StoreOnBoardInfo() async {
    int isViewed = 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: PageView.builder(
            itemCount: screen.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int index) {
              setState(() {
                currentIndex = index;
                _textAnimationController
                    .reset(); // Reiniciar la animación al cambiar de página
                _textAnimationController.forward();
              });
            },
            itemBuilder: (context, index) {
              return Column(
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
                  SlideTransition(
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
                  ),
                  InkWell(
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
                ],
              );
            }),
      ),
    );
  }
}
