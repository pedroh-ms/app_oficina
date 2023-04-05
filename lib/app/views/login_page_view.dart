import 'package:app_oficina/app/controllers/login_page_controller.dart';
import 'package:flutter/material.dart';
import 'home_page_view.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  String usuario = '';
  String senha = '';

  final _loginPageController = LoginPageController();

  Future<void> _login() async {
    _loginPageController.permitirLogin(usuario, senha).then(
      (allow) {
        if (allow) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage()
            )
          );
        }
      }
    );    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (text) {
                usuario = text;
              },
              decoration: const InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder()
                ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextField(
              onChanged: (text) {
                senha = text;
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async => await _login(), 
              child: const Text('Entrar')
            )
          ],
        )
      ),
    );
  }
}