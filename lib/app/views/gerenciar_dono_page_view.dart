import 'package:app_oficina/app/controllers/gerenciar_dono_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GerenciarDonoPage extends StatefulWidget {

  final int? id;
  final String? nome;
  final String? numeroCelular;

  const GerenciarDonoPage({this.id, this.nome, this.numeroCelular});

  @override
  GerenciarDonoPageState createState() => GerenciarDonoPageState(id, nome, numeroCelular);
}

class GerenciarDonoPageState extends State<GerenciarDonoPage> {

  final _nomeController = TextEditingController();
  final _numeroCelularController = TextEditingController();
  final _gerenciarDonoPageController = GerenciarDonoPageController();

  int? id;
  String nome = '';
  String numeroCelular = '';

  GerenciarDonoPageState(int? id, String? nome, String? numeroCelular) {
    _nomeController.text = nome != null ? nome : '';
    _numeroCelularController.text = numeroCelular != null ? numeroCelular : '';
    this.id = id;
    this.nome = _nomeController.text;
    this.numeroCelular = _numeroCelularController.text;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar dono'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nomeController,
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
                controller: _numeroCelularController,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _gerenciarDonoPageController.salvar(
                        <String, dynamic>{
                          'id': id,
                          'nome': nome,
                          'numeroCelular': numeroCelular
                        }
                      );
                    }, 
                    child: Text('Salvar')
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _gerenciarDonoPageController.deletar(id as int);
                    }, 
                    child: Text('Deletar')
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}