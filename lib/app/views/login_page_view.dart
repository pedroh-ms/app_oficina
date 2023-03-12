import 'package:app_oficina/app/controllers/login_page_controller.dart';
import 'package:app_oficina/app/views/donos_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'home_page_view.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  String usuario = '';
  String senha = '';

  final _loginPageController = LoginPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login')
              ],
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (text) {
                usuario = text;
              },
              decoration: InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder()
                ),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              onChanged: (text) {
                senha = text;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                if (await _loginPageController.permitirLogin(usuario, senha)) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage()
                      )
                  );
                }
              }, 
              child: Text('Entrar')
            )
          ],
        )
      ),
    );
  }
}