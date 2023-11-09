import 'package:flutter/material.dart';
import 'package:flutter_app/firebase/email_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conNameUser = TextEditingController();
  final conEmailUser =TextEditingController();
  final conPwdUsr= TextEditingController();
  final emailAuth = EmailAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar usuario'),
      ),
      body: Column(
        children: [
          TextField(
            controller: conNameUser,
          ),
          TextField(
            controller: conEmailUser,
          ),
          TextFormField(
            controller: conPwdUsr,
          ),
          ElevatedButton(onPressed: (){
            var email = conEmailUser.text;
            var pwd = conPwdUsr.text;
            emailAuth.createUser(emailUser: email, pwdUsr: pwd);
          }, child: Text('Save user'))
        ],
      ),
    );
    
  }
}