import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../controllers/gerenciar_carro_page_controller.dart';
import '../models/dono_model.dart';

class GerenciarCarroPage extends StatefulWidget {
  
  final int? id;
  final String? nome;
  final String? cor;
  final DonoModel? dono;
  final List<DonoModel>? donos;

  GerenciarCarroPage({this.id, this.nome, this.cor, this.dono, this.donos});

  @override
  GerenciarCarroPageState createState() => GerenciarCarroPageState(id, nome, cor, dono, donos);
}

class GerenciarCarroPageState extends State<GerenciarCarroPage> {
  
  final _nomeController = TextEditingController();
  final _corController = TextEditingController();
  final _gerenciarCarroPageController = GerenciarCarroPageController();

  int? id;
  String nome = '';
  String cor = '';
  late DonoModel dono;
  List<DonoModel>? donos;

  GerenciarCarroPageState(int? id, String? nome, String? cor, DonoModel? dono, List<DonoModel>? donos) {
    _nomeController.text = nome != null ? nome : '';
    _corController.text = cor != null ? cor : '';
    this.id = id;
    this.nome = _nomeController.text;
    this.cor = _corController.text;
    this.dono = dono as DonoModel;
    this.donos = donos;
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inserir carro')
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
                controller: _corController,
                onChanged: (text) {
                  cor = text;
                },
                decoration: InputDecoration(
                  labelText: 'Cor',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SearchField<DonoModel>(
                initialValue: SearchFieldListItem<DonoModel>(
                  dono.nome as String,
                  item: dono,
                  child: Text(dono.nome as String)
                ),
                suggestions: (donos!)
                  .map(
                    (e) => SearchFieldListItem<DonoModel>(
                      e.nome as String,
                      item: e,
                      child: Text(e.nome as String)
                    )
                  ).toList(),
                searchInputDecoration: InputDecoration(
                  labelText: 'Dono',
                  border: OutlineInputBorder()
                ),
                onSuggestionTap: (e) {
                  dono = e.item as DonoModel;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await _gerenciarCarroPageController.salvar(
                        <String, dynamic>{
                          'id': id,
                          'nome': nome,
                          'cor': cor,
                          'dono_id': dono.id
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
                      await _gerenciarCarroPageController.deletar(id as int);
                    },
                    child: Text('Deletar')
                  )
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}