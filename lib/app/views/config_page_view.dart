import 'package:app_oficina/app/controllers/config_page_controller.dart';
import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  ConfigPageState createState() => ConfigPageState();
}

class ConfigPageState extends State<ConfigPage> {
  final _controller = ConfigPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurar conexão')
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                onChanged: (text) => _controller.host = text,
                decoration: const InputDecoration(
                  labelText: 'Host',
                  border: OutlineInputBorder() 
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                onChanged: (text) => _controller.port = text,
                decoration: const InputDecoration(
                  labelText: 'Porta',
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () => _controller.save(), 
                child: const Text('Salvar')
              )
            ]
          )
        )
      ),
    );
  }
}