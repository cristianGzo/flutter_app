import 'package:flutter/material.dart';

class OpcionesScreen extends StatefulWidget {
  const OpcionesScreen({super.key});

  @override
  State<OpcionesScreen> createState() => _OpcionesScreenState();
}

class _OpcionesScreenState extends State<OpcionesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido elija una opción'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tareas');
                },
                child: Text(
                  "Task",
                  style: TextStyle(
                    fontSize: 24,
                    //fontWeight: FontWeight.bold
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10,),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/maestros');
                },
                child: Text(
                  "Maestros",
                  style: TextStyle(
                    fontSize: 24,
                    //fontWeight: FontWeight.bold
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          18), // Ajusta el radio para hacer el borde redondo
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            SizedBox(
              width: 150,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/carrera');
                  },
                  child: Text(
                    "Carrera",
                    style: TextStyle(
                      fontSize: 24,
                      //fontWeight: FontWeight.bold
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            18), // Ajusta el radio para hacer el borde redondo
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
