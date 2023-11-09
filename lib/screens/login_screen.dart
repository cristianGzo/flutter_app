import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //para login hasta antes del @oveeride
  bool isSessionSaved = false;
  

  void initState() {
    super.initState();
    checkSavedSession(); // Verificar si hay una sesión guardada al iniciar la aplicación
  }

  void checkSavedSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? sessionSaved = prefs.getBool('sessionSaved');
    if (sessionSaved != null && sessionSaved) {
      // Si la sesión está guardada, redirige automáticamente al Dashboard
      Navigator.pushReplacementNamed(context, '/dash');
      setState(() {
       isSessionSaved=isSessionSaved ?? false; 
      });
    }
  }

  void saveSession(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('sessionSaved', value);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController txtConUser = TextEditingController();
    TextEditingController txtConPass = TextEditingController();
    //cajas de texto del login
    final txtUser = TextField(
      controller: txtConUser,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );

    final txtPass = TextField(
      controller: txtConPass,
      decoration: const InputDecoration(border: OutlineInputBorder()),
      obscureText: true,
    );
//container equivalente a un div en web
    final imgLogo = Container(
      width: 150,
      margin: EdgeInsets.only(bottom: 180),
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/logo.png')),
      ),
    );

    final btnentrar = FloatingActionButton.extended(
      label: Text('Entrar'),
      icon: Icon(Icons.login),
      backgroundColor: Colors.green,
      onPressed: () async {
        // Navigator.pushNamed(context, '/dash');
        if (isSessionSaved) {
          saveSession(true); // Guardar la sesión solo si el checkbox está marcado.
        }
        //Navigator.pushNamed(context, '/dash');
        Navigator.pushReplacementNamed(context, '/dash');
      },
    );

    //sto tambien es del login
    final sessionCheckbox = Checkbox(
      value: isSessionSaved,
      onChanged: (value) {
        setState(() {
          isSessionSaved = value!;
        });
      },
    );

    final sessionCheckboxContainer = Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar el checkbox
        children: [
          Text('Guardar sesión'),
          SizedBox(width: 10.0),
          sessionCheckbox,
        ],
      ),
    );

//esto es lo que se va mostrar en pantalla y se acomoda como pila
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height, //para la responsividad
        decoration: const BoxDecoration(
            image: DecorationImage(
                opacity: 1,
                fit: BoxFit.fill,
                image: AssetImage('assets/backLg.jpg'))),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100.0),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: 200,
                //color: Colors.grey,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(30),

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 23, 36, 53)),
                child: Column(
                  // padding: EdgeInsets.symmetric(horizontal: 10),//para agregar paddin solo en lo horizontal symetrcic para eso se usa
                  children: [
                    txtUser, const SizedBox(height: 10), txtPass],
                ),
              ),
              imgLogo,
              TextButton(onPressed: (){
                Navigator.pushNamed(context, 'register');
              }, child: Text('Registrar', style: TextStyle(fontSize: 20),)),
              sessionCheckboxContainer,
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: btnentrar,
    );
  }
}
