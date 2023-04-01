import 'package:app_oficina/app/views/carros_page_view.dart';
import 'package:app_oficina/app/views/material_comprados_page_view.dart';
import 'package:app_oficina/app/views/servicos_page_view.dart';
import 'package:flutter/material.dart';

import 'donos_page_view.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text('Donos'),
              subtitle: Text('Gerenciar ou adicionar donos'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DonosPage()
                )
              ),
            ),
            ListTile(
              title: Text('Carros'),
              subtitle: Text('Gerenciar ou adicionar carros'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CarrosPage()
                )
              ),
            ),
            ListTile(
              title: Text('Servicos'),
              subtitle: Text('Gerenciar ou adicionar servicos'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ServicosPage()
                )
              )
            ),
            ListTile(
              title: Text('Materiais comprados'),
              subtitle: Text('Gerenciar ou acicionar materiais comprados'),
              onTap:() => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MaterialCompradosPage())
              ),
            )
          ],
        ),
      ),
    );
  }
}