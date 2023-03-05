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
            )
          ],
        ),
      ),
    );
  }
}