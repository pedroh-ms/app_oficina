import 'package:app_oficina/app/views/carros_page_view.dart';
import 'package:app_oficina/app/views/material_comprados_page_view.dart';
import 'package:app_oficina/app/views/servicos_page_view.dart';
import 'package:flutter/material.dart';

import 'donos_page_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: const Text('Donos'),
              subtitle: const Text('Gerenciar ou adicionar donos'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DonosPage()
                )
              ),
            ),
            ListTile(
              title: const Text('Carros'),
              subtitle: const Text('Gerenciar ou adicionar carros'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CarrosPage()
                )
              ),
            ),
            ListTile(
              title: const Text('Servicos'),
              subtitle: const Text('Gerenciar ou adicionar servicos'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ServicosPage()
                )
              )
            ),
            ListTile(
              title: const Text('Materiais comprados'),
              subtitle: const Text('Gerenciar ou acicionar materiais comprados'),
              onTap:() => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MaterialCompradosPage())
              ),
            )
          ],
        ),
      ),
    );
  }
}