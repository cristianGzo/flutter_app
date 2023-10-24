import 'package:flutter/material.dart';
import 'package:flutter_app/provider/test_provider.dart';
import 'package:provider/provider.dart';

class ProviderScreen extends StatelessWidget {
  const ProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<TestProvider>(context);
    return Scaffold(
      body: Center(
        child: Text(userProvider.user), //user es el metodo get
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        userProvider.user = 'rubensin 2';
      }),
    );
  }
}

// pasos para utilizar provider definir clase, envolver material app(del main para que escuche desde la raiz) , el terrcer paso es donde se va a utilizar en este caso en el provider screen
