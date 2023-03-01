import 'package:app_oficina/app/controllers/inserir_dono_page_controller.dart';
import 'package:flutter/material.dart';

class InserirDonoPage extends StatefulWidget {
  @override
  InserirDonoPageState createState() => InserirDonoPageState();
}

class InserirDonoPageState extends State<InserirDonoPage> {

  String nome = '';
  String numeroCelular = '';

  final _inserirDonoPageController = InserirDonoPageController();

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
                    nome = text;
                  },
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  onChanged: (text) {
                    numeroCelular = text;
                  },
                  decoration: InputDecoration(
                    labelText: 'Número do celular',
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final ret = await _inserirDonoPageController.inserir({
                      'nome': nome,
                      'numeroCelular': numeroCelular
                      }
                    );
                    print(ret);
                  }, 
                  child: Text('Inserir')
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}