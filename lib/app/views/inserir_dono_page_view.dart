import 'package:app_oficina/app/controllers/inserir_dono_page_controller.dart';
import 'package:app_oficina/app/models/dono_model.dart';
import 'package:flutter/material.dart';

class InserirDonoPage extends StatefulWidget {
  const InserirDonoPage({super.key});

  @override
  InserirDonoPageState createState() => InserirDonoPageState();
}

class InserirDonoPageState extends State<InserirDonoPage> {

  final dono = DonoModel();

  final _inserirDonoPageController = InserirDonoPageController();

  Future<void> _insert() async {
    await _inserirDonoPageController.insert(dono.toJson());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserir dono')
      ),
      body: SingleChildScrollView(
        child: (
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (text) {
                    dono.nome = text;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  onChanged: (text) {
                    dono.numeroCelular = text;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Número do celular',
                    border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async => await _insert(), 
                  child: const Text('Inserir')
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}